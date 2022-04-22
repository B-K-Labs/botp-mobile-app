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
  // Constants
  final periodGetTransactionDetail = 10;
  final periodOtp = otpPeriodSecond;
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
    // On initial state + refresh
    on<TransactionDetailEventGetTransactionDetailAndSetupTimer>(
        (event, emit) async {
      await _getTransactionDetailAndSetupTimers(emit);
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
        // Update & store secret message (IMPORTANT)
        otpSessionSecretInfo
            .setSecretMessage(confirmTransactionResult.secretMessage);
        _setSecretMessage(otpSessionSecretInfo.secretId,
            confirmTransactionResult.secretMessage);
        // Change to pending status
        _changeTransactionStatusTemporarily(emit, TransactionStatus.pending);
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        _getTransactionDetailAndSetupTimers(emit);
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
        otpSessionSecretInfo.clearSecretMessage();
        // Change to failed
        _changeTransactionStatusTemporarily(emit, TransactionStatus.failed);
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        _getTransactionDetailAndSetupTimers(emit);
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
        otpSessionSecretInfo.clearSecretMessage();
        // Change to failed
        _changeTransactionStatusTemporarily(emit, TransactionStatus.failed);
        // Sync data
        emit(state.copyWith(userRequestStatus: RequestStatusSuccess()));
        _isUserRequestSubmitting = false;
        _getTransactionDetailAndSetupTimers(emit);
      } on Exception catch (e) {
        emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
        _isUserRequestSubmitting = false;
      }
    });
  }

  // Timers
  // 1. Get Transaction Detail Timer
  // Note: set interval instead of socket listening :pepe-sad:
  _setupGetTransactionDetailTimer(emit) {
    if (_isGetTransactionDetailTimerRunning) return;
    _isGetTransactionDetailTimerRunning = true;
    getTransactionDetailTimer = Timer.periodic(
        Duration(seconds: periodGetTransactionDetail), (Timer timer) {
      if (isClosed || (!_isGetTransactionDetailTimerRunning)) {
        timer.cancel(); // When the stream is closed, or actively stop
      } else {
        _getTransactionDetailAndSetupTimers(emit);
      }
    });
  }

  _cancelGetTransactionDetailTimer() {
    getTransactionDetailTimer?.cancel();
    _isGetTransactionDetailTimerRunning = false;
  }

  // 2. Generate OTP Timer
  _setupAndRunGenerateOtpTimer(emit) {
    if (_isGenerateOtpTimerRunning) return;
    _isGenerateOtpTimerRunning = true;
  }

  _cancelGenerateOtpTimer() {
    generateOtpTimer?.cancel();
    generateOtpTimer = null;
    _isGenerateOtpTimerRunning = false;
  }

  // Core functions
  // 1. Get transaction detail + setup timers
  _getTransactionDetailAndSetupTimers(emit) async {
    if (_isGetTransactionInfoSubmitting) return;
    _isGetTransactionInfoSubmitting = true;
    try {
      // Get transaction detail
      final getTransactionDetailResult = await authenticatorRepository
          .getTransactionDetail(otpSessionSecretInfo.secretId);
      // - Get new info
      final newOtpSessionInfo =
          getTransactionDetailResult.transactionDetail.otpSessionInfo;
      // - Get new secret info
      otpSessionSecretInfo =
          getTransactionDetailResult.transactionDetail.otpSessionSecretInfo;
      emit(state.copyWith(otpSessionInfo: newOtpSessionInfo));

      // Secret message
      if (newOtpSessionInfo.transactionStatus == TransactionStatus.pending) {
        final secretMessage =
            await _getSecretMessage(otpSessionSecretInfo.secretId);
        otpSessionSecretInfo.setSecretMessage(secretMessage);
      } else {
        _removeSecretMessage(otpSessionSecretInfo.secretId);
      }

      // Setup timers
      // - Setup timer: get transaction detail
      if (newOtpSessionInfo.transactionStatus == TransactionStatus.requesting) {
        _setupGetTransactionDetailTimer(emit);
      }
      // - Setup timers: get transaction detail + generate otp
      else if (newOtpSessionInfo.transactionStatus ==
          TransactionStatus.pending) {
        _setupGetTransactionDetailTimer(emit);
        _setupAndRunGenerateOtpTimer(emit);
      }
      // - Cancel all timers
      else {
        _cancelGenerateOtpTimer();
        _cancelGetTransactionDetailTimer();
      }
    } on Exception catch (e) {
      emit(state.copyWith(userRequestStatus: RequestStatusFailed(e)));
    }
    _isGetTransactionInfoSubmitting = false;
  }

  // 2. Generate OTP
  _generateOtp(emit) async {
    try {
      // If OTP is valid, just count down
      if (state.otpValueInfo.status == OTPValueStatus.valid) {
        final newOtpValueInfo = state.otpValueInfo;
        newOtpValueInfo.countdown();
        emit(state.copyWith(otpValueInfo: newOtpValueInfo));
      } else {
        final keyMessage = otpSessionSecretInfo.secretMessage;
        if (keyMessage == null) {
          // Invalid otp value: stop the timer

          emit(state.copyWith(otpValueInfo: OTPValueInfo()));
          return;
        }
        // Self-generating OTP
        final otpGeneratedTime = DateTime.now().millisecondsSinceEpoch;
        final otpValue = generateTOTP(
            keyMessage, digits, periodOtp, otpGeneratedTime, algorithm);
        // Calculate the otp remaining time
        final otpRemainingTime = (otpGeneratedTime +
                periodOtp * Duration.millisecondsPerSecond -
                otpGeneratedTime) ~/
            Duration.millisecondsPerSecond;
        // Update state
        emit(state.copyWith(
            otpValueInfo: OTPValueInfo(
                value: otpValue, remainingSecond: otpRemainingTime)));
      }
    } on Exception catch (e) {
      // TODO: otp status
    }
  }

  // Util functions
  // 1. Change transaction status temporarily (but immediately)
  _changeTransactionStatusTemporarily(
      emit, TransactionStatus transactionStatus) {
    emit(state.copyWith(
        otpSessionInfo: state.otpSessionInfo
            ?.copyWith(transactionStatus: transactionStatus)));
  }

  // 2. Secret Message
  // - Get secret message
  _getSecretMessage(String secretId) async {
    final transactionsData =
        await UserData.getCredentialTransactionsSecretData();
    // Note: Secret message is saved in the confirmation event
    return transactionsData?.objTransactionSecretMessages[secretId];
  }

  _setSecretMessage(String secretId, String secretMessage) async {
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
  }
}
