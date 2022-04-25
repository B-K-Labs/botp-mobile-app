import 'dart:async';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_event.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_state.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:botp_auth/utils/services/crypto_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  AuthenticatorRepository authenticatorRepository;
  // Timer
  final periodGetTransactionDetail = socketPeriodSecond;
  final periodOtp = 1;
  // Otp generator
  final period = otpPeriodSecond; // otpPeriod;
  final digits = otpDigits;
  final algorithm = otpAlgorithm;
  final countdown = 1;
  // Timers
  Timer? getTransactionDetailTimer;
  Timer? generateOtpTimer;
  // OTP Session
  OTPSessionSecretInfo otpSessionSecretInfo;
  // Flags: race condition
  bool _isUserRequestSubmitting = false;
  bool _isGetTransactionInfoSubmitting = false;
  bool _isGenerateOtpSubmitting = false;
  bool _isGetTransactionDetailTimerRunning = false;
  bool _isGenerateOtpTimerRunning = false;

  TransactionDetailBloc(
      {required this.authenticatorRepository,
      required this.otpSessionSecretInfo})
      : super(TransactionDetailState(otpValueInfo: OTPValueInfo())) {
    // Core events
    // 1. Get transaction detail + setup timers
    on<TransactionDetailEventGetTransactionDetailAndRunSetupTimers>(
        (event, emit) async {
      if (isClosed || _isGetTransactionInfoSubmitting) return;
      _isGetTransactionInfoSubmitting = true;
      try {
        emit(state.copyWith(
            getTransactionDetailStatus: RequestStatusSubmitting()));
        // Get transaction detail
        final getTransactionDetailResult = await authenticatorRepository
            .getTransactionDetail(otpSessionSecretInfo.secretId);
        // - Get new transaction info
        final newOtpSessionInfo =
            getTransactionDetailResult.transactionDetail.otpSessionInfo;
        // - Get new transaction secret info
        otpSessionSecretInfo =
            getTransactionDetailResult.transactionDetail.otpSessionSecretInfo;

        // Sync/remove secret message
        if (newOtpSessionInfo.transactionStatus == TransactionStatus.pending) {
          await _syncSecretMessage(otpSessionSecretInfo.secretId);
        } else {
          _removeSecretMessage(otpSessionSecretInfo.secretId);
        }

        // Setup timers
        // - Setup timer: get transaction detail
        if (newOtpSessionInfo.transactionStatus ==
            TransactionStatus.requesting) {
          add(TransactionDetailEventSetupGetTransactionDetailTimer());
        }
        // - Setup timers: get transaction detail + generate otp
        else if (newOtpSessionInfo.transactionStatus ==
            TransactionStatus.pending) {
          add(TransactionDetailEventSetupGetTransactionDetailTimer());
          add(TransactionDetailEventSetupGenerateOTPTimer());
        }
        // - Cancel all timers
        else {
          _cancelGetTransactionDetailTimer();
          _cancelGenerateOtpTimer();
        }

        // Update state
        emit(state.copyWith(
            otpSessionInfo: newOtpSessionInfo,
            getTransactionDetailStatus: RequestStatusSubmitting()));
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
      }
      _isGetTransactionInfoSubmitting = false;
    });

    // 2. Generate OTP
    on<TransactionDetailEventGenerateOTPAndSetupTimer>((event, emit) async {
      if (isClosed || _isGenerateOtpSubmitting) return;
      _isGenerateOtpSubmitting = true;
      try {
        // (updated) If OTP is valid and not expired, just count down the time
        if ([OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
            .contains(state.otpValueInfo.status)) {
          final newOtpValueInfo = state.otpValueInfo;
          newOtpValueInfo.countdown();
          if (newOtpValueInfo.status != OTPValueStatus.expired) {
            emit(state.copyWith(otpValueInfo: newOtpValueInfo));
            _isGenerateOtpSubmitting = false;
            return;
          }
        }
        // Else, create a new one
        emit(state.copyWith(generateOtpStatus: RequestStatusSubmitting()));
        // OTP in RAM that was synced with local storage
        final keyMessage = otpSessionSecretInfo.secretMessage;
        // (updated) Key message not found: throw error
        if (keyMessage == null) {
          // Stop the timer
          _cancelGenerateOtpTimer();
          // Update OTP value
          emit(state.copyWith(
              generateOtpStatus: RequestStatusSuccess(),
              otpValueInfo: OTPValueInfo(notAvailable: true)));
        }
        // Key message found: Generate OTP
        else {
          // Generate OTP
          final otpGeneratedTime = DateTime.now().millisecondsSinceEpoch;
          final otpValue = generateTOTP(
              keyMessage, digits, period, otpGeneratedTime, algorithm);
          // - Calculate the otp remaining time
          final otpRemainingTime = period -
              ((otpGeneratedTime ~/ Duration.millisecondsPerSecond + period) %
                  period);
          // Setup timer: Generate OTP
          add(TransactionDetailEventSetupGenerateOTPTimer());
          // Update OTP value
          emit(state.copyWith(
              generateOtpStatus: RequestStatusSuccess(),
              otpValueInfo: OTPValueInfo(
                  value: otpValue,
                  remainingSecond: otpRemainingTime,
                  totalSeconds: otpPeriodSecond)));
        }
      } on Exception catch (e) {
        // Stop the timer
        _cancelGenerateOtpTimer();
        // Update state
        emit(state.copyWith(generateOtpStatus: RequestStatusFailed(e)));
      }
      _isGenerateOtpSubmitting = false;
      emit(state.copyWith(generateOtpStatus: const RequestStatusInitial()));
    });

    // User request actions
    // 1. Confirm transaction
    on<TransactionDetailEventConfirmTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        emit(state.copyWith(userRequestStatus: RequestStatusSubmitting()));
        final accountData = await UserData.getCredentialAccountData();
        final confirmTransactionResult =
            await authenticatorRepository.confirmTransaction(
                otpSessionSecretInfo.secretId, accountData!.password);
        // Save secret message (IMPORTANT)
        _saveSecretMessage(otpSessionSecretInfo.secretId,
            confirmTransactionResult.secretMessage);
        // Change to pending status
        add(TransactionDetailEventChangeTransactionStatusTemporarily(
            transactionStatus: TransactionStatus.pending));
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        emit(state.copyWith(userRequestStatus: const RequestStatusInitial()));
        add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
        emit(state.copyWith(userRequestStatus: const RequestStatusInitial()));
      }
    });

    // 2. Reject transaction
    on<TransactionDetailEventRejectTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        emit(state.copyWith(userRequestStatus: RequestStatusSubmitting()));
        final accountData = await UserData.getCredentialAccountData();
        await authenticatorRepository.denyTransaction(
            otpSessionSecretInfo.secretId, accountData!.password);
        // Clean message
        _removeSecretMessage(otpSessionSecretInfo.secretId);
        // Change to failed
        add(TransactionDetailEventChangeTransactionStatusTemporarily(
            transactionStatus: TransactionStatus.failed));
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        emit(state.copyWith(userRequestStatus: const RequestStatusInitial()));
        add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
        emit(state.copyWith(userRequestStatus: const RequestStatusInitial()));
      }
    });

    // 3. Cancel transaction
    on<TransactionDetailEventCancelTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        emit(state.copyWith(userRequestStatus: RequestStatusSubmitting()));
        final accountData = await UserData.getCredentialAccountData();
        await authenticatorRepository.cancelTransaction(
            otpSessionSecretInfo.secretId, accountData!.password);
        // Clean message
        _removeSecretMessage(otpSessionSecretInfo.secretId);
        // Change to failed
        add(TransactionDetailEventChangeTransactionStatusTemporarily(
            transactionStatus: TransactionStatus.failed));
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        emit(state.copyWith(userRequestStatus: const RequestStatusInitial()));
        add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
        emit(state.copyWith(userRequestStatus: const RequestStatusInitial()));
      }
    });

    // Timers
    // 1. Get Transaction Detail Timer
    // Note: set interval instead of socket listening :pepe-sad:
    on<TransactionDetailEventSetupGetTransactionDetailTimer>(
        (event, emit) async {
      if (_isGetTransactionDetailTimerRunning) return;
      _isGetTransactionDetailTimerRunning = true;
      getTransactionDetailTimer = Timer.periodic(
          Duration(seconds: periodGetTransactionDetail), (Timer timer) {
        if (isClosed || (!_isGetTransactionDetailTimerRunning)) {
          _cancelGetTransactionDetailTimer();
        } else {
          add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
        }
      });
    });

    on<TransactionDetailEventSetupGenerateOTPTimer>((event, emit) async {
      if (_isGenerateOtpTimerRunning) return;
      _isGenerateOtpTimerRunning = true;
      generateOtpTimer = Timer.periodic(Duration(seconds: periodOtp), (timer) {
        if (isClosed || !_isGenerateOtpTimerRunning) {
          _cancelGenerateOtpTimer();
        } else {
          add(TransactionDetailEventGenerateOTPAndSetupTimer());
        }
      });
    });

    // Help user not wait for new status longer
    on<TransactionDetailEventChangeTransactionStatusTemporarily>(
        (event, emit) => emit(state.copyWith(
            otpSessionInfo: state.otpSessionInfo
                ?.copyWith(transactionStatus: event.transactionStatus))));

    // Copy actions
    on<TransactionDetailEventCopyBcAddress>((event, emit) async {
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSubmitting()));
      // Copy blockchain address to clipboard
      await setClipboardData(state.otpSessionInfo!.agentBcAddress);
      try {
        emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusFailed(e)));
      } finally {
        emit(state.copyWith(
            copyBcAddressStatus: const SetClipboardStatusInitial()));
      }
    });

    on<TransactionDetailEventCopyOTP>((event, emit) async {
      if ([OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
          .contains(state.otpValueInfo.status)) {
        emit(state.copyWith(copyOtpStatus: SetClipboardStatusSubmitting()));
        // Copy OTP to clipboard
        await setClipboardData(state.otpValueInfo.value);
        try {
          emit(state.copyWith(copyOtpStatus: SetClipboardStatusSuccess()));
        } on Exception catch (e) {
          emit(state.copyWith(copyOtpStatus: SetClipboardStatusFailed(e)));
        } finally {
          emit(
              state.copyWith(copyOtpStatus: const SetClipboardStatusInitial()));
        }
      }
    });
  }

  // Common functions
  // - Cancel timers
  _cancelGetTransactionDetailTimer() {
    getTransactionDetailTimer?.cancel();
    _isGetTransactionDetailTimerRunning = false;
  }

  _cancelGenerateOtpTimer() {
    generateOtpTimer?.cancel();
    generateOtpTimer = null;
    _isGenerateOtpTimerRunning = false;
  }

  // - Secret message manipulation
  _syncSecretMessage(String secretId) async {
    final transactionsData =
        await UserData.getCredentialTransactionsSecretData();
    // Note: Secret message is saved in the confirmation event
    otpSessionSecretInfo.setSecretMessage(
        transactionsData?.objTransactionSecretMessages[secretId]);
  }

  _saveSecretMessage(String secretId, String secretMessage) async {
    final transactionData =
        await UserData.getCredentialTransactionsSecretData();
    if (transactionData == null) {
      await UserData.setCredentialTransactionsSecretData(
          {secretId: secretMessage});
    } else {
      final objTransactionSecretMessages =
          transactionData.objTransactionSecretMessages;
      objTransactionSecretMessages[otpSessionSecretInfo.secretId] =
          secretMessage;
      await UserData.setCredentialTransactionsSecretData(
          objTransactionSecretMessages);
    }
    otpSessionSecretInfo.setSecretMessage(secretMessage);
  }

  _removeSecretMessage(String secretId) async {
    final transactionData =
        await UserData.getCredentialTransactionsSecretData();
    if (transactionData != null) {
      transactionData.objTransactionSecretMessages
          .removeWhere((key, value) => key == secretId);
      await UserData.setCredentialTransactionsSecretData(
          transactionData.objTransactionSecretMessages);
    }
    otpSessionSecretInfo.clearSecretMessage();
  }
}
