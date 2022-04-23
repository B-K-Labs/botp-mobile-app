import 'dart:async';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_event.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_state.dart';
import 'package:botp_auth/utils/services/crypto_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  AuthenticatorRepository authenticatorRepository;
  // Timer
  final periodGetTransactionDetail = 10;
  final periodOtp = 1;
  // Otp generator
  final period = 10;
  final digits = otpDigits;
  final algorithm = otpAlgorithm;
  final countdown = 1;
  // Timers
  Timer? getTransactionDetailTimer;
  Timer? generateOtpTimer;
  // OTP Session
  OTPSessionSecretInfo otpSessionSecretInfo;
  // Flags
  bool _isUserRequestSubmitting = false;
  bool _isGetTransactionInfoSubmitting = false;
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
      if (_isGetTransactionInfoSubmitting) return;
      _isGetTransactionInfoSubmitting = true;
      try {
        // Get transaction detail
        final getTransactionDetailResult = await authenticatorRepository
            .getTransactionDetail(otpSessionSecretInfo.secretId);
        // - Get new transaction info
        final newOtpSessionInfo =
            getTransactionDetailResult.transactionDetail.otpSessionInfo;
        // - Get new transaction secret info
        otpSessionSecretInfo =
            getTransactionDetailResult.transactionDetail.otpSessionSecretInfo;
        emit(state.copyWith(otpSessionInfo: newOtpSessionInfo));

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
          add(TransactionDetailEventSetupAndRunGenerateOTPTimer());
        }
        // - Cancel all timers
        else {
          add(TransactionDetailEventCancelGetTransactionDetailTimer());
          add(TransactionDetailEventCancelGenerateOTPTimer());
        }
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
      }
      _isGetTransactionInfoSubmitting = false;
    });

    // 2. Generate OTP
    on<TransactionDetailEventGenerateOTP>((event, emit) async {
      try {
        // If OTP is valid, just count down
        if (state.otpValueInfo.status == OTPValueStatus.valid) {
          final newOtpValueInfo = state.otpValueInfo;
          newOtpValueInfo.countdown();
          emit(state.copyWith(otpValueInfo: newOtpValueInfo));
        }
        // Else, create a new one
        else {
          final keyMessage = otpSessionSecretInfo.secretMessage;
          // Invalid key message: OTP not available
          if (keyMessage == null) {
            emit(state.copyWith(otpValueInfo: OTPValueInfo()));
            return;
          }
          // Generate OTP
          final otpGeneratedTime = DateTime.now().millisecondsSinceEpoch;
          final otpValue = generateTOTP(
              keyMessage, digits, period, otpGeneratedTime, algorithm);
          // Calculate the otp remaining time
          final otpRemainingTime = (otpGeneratedTime +
                  period * Duration.millisecondsPerSecond -
                  otpGeneratedTime) ~/
              Duration.millisecondsPerSecond;
          // Update OTP value
          emit(state.copyWith(
              otpValueInfo: OTPValueInfo(
                  value: otpValue, remainingSecond: otpRemainingTime)));
        }
      } on Exception catch (e) {
        // TODO: otp status
      }
    });

    // User request actions
    // 1. Confirm transaction
    on<TransactionDetailEventConfirmTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      emit(state.copyWith(userRequestStatus: RequestStatusSubmitting()));
      try {
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
        add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
      }
    });

    // 2. Reject transaction
    on<TransactionDetailEventRejectTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        final accountData = await UserData.getCredentialAccountData();
        await authenticatorRepository.denyTransaction(
            otpSessionSecretInfo.secretId, accountData!.password);
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        // Clean message
        _removeSecretMessage(otpSessionSecretInfo.secretId);
        // Change to failed
        add(TransactionDetailEventChangeTransactionStatusTemporarily(
            transactionStatus: TransactionStatus.failed));
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
      }
    });

    // 3. Cancel transaction
    on<TransactionDetailEventCancelTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        final accountData = await UserData.getCredentialAccountData();
        await authenticatorRepository.cancelTransaction(
            otpSessionSecretInfo.secretId, accountData!.password);
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        // Clean message
        _removeSecretMessage(otpSessionSecretInfo.secretId);
        // Change to failed
        add(TransactionDetailEventChangeTransactionStatusTemporarily(
            transactionStatus: TransactionStatus.failed));
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
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
          add(TransactionDetailEventCancelGetTransactionDetailTimer()); // When the stream is closed, or actively stop
        } else {
          add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers());
        }
      });
    });

    on<TransactionDetailEventCancelGetTransactionDetailTimer>((event, emit) {
      getTransactionDetailTimer?.cancel();
      _isGetTransactionDetailTimerRunning = false;
    });

    on<TransactionDetailEventSetupAndRunGenerateOTPTimer>((event, emit) async {
      if (_isGenerateOtpTimerRunning) return;
      _isGenerateOtpTimerRunning = true;
      add(TransactionDetailEventGenerateOTP()); // TODO: should wait ?
      generateOtpTimer = Timer.periodic(Duration(seconds: periodOtp), (timer) {
        if (isClosed || !_isGenerateOtpTimerRunning) {
          add(TransactionDetailEventCancelGenerateOTPTimer());
        } else {
          add(TransactionDetailEventGenerateOTP());
        }
      });
    });

    on<TransactionDetailEventCancelGenerateOTPTimer>((event, emit) {
      generateOtpTimer?.cancel();
      generateOtpTimer = null;
      _isGenerateOtpTimerRunning = false;
    });

    on<TransactionDetailEventChangeTransactionStatusTemporarily>(
        (event, emit) => emit(state.copyWith(
            otpSessionInfo: state.otpSessionInfo
                ?.copyWith(transactionStatus: event.transactionStatus))));
  }

  // Util functions
  // - Get secret message
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

  // Remove secret message
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
