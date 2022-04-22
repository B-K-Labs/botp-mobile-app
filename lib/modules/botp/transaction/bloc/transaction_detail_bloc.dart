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
  final digits = otpDigits;
  final periodSecond = otpPeriodSecond;
  final algorithm = otpAlgorithm;
  Timer? timer;
  // Bloc keep all otp session info
  OTPSessionInfo otpSessionInfo;
  OTPSessionSecretInfo otpSessionSecretInfo;
  // Flags
  bool _isUserRequestSubmitting = false;
  bool _isGetTransactionInfoSubmitting = false;
  bool _cancelGenerateOtp = false;

  TransactionDetailBloc(
      {required this.authenticatorRepository,
      required this.otpSessionInfo,
      required this.otpSessionSecretInfo})
      : super(TransactionDetailState(
            otpSessionInfo: otpSessionInfo, otpValueInfo: OTPValueInfo())) {
    on<TransactionDetailEventInitState>((event, emit) async {
      await _getTransactionDetail(emit);
    });
    on<TransactionDetailEventGetDetail>((event, emit) async {
      await _getTransactionDetail(emit);
    });
    on<TransactionDetailEventConfirmTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      emit(state.copyWith(transactionActionStatus: RequestStatusSubmitting()));
      try {
        final accountData = await UserData.getCredentialAccountData();
        final confirmTransactionResult =
            await authenticatorRepository.confirmTransaction(
                otpSessionSecretInfo.secretId, accountData!.password);
        emit(state.copyWith(transactionActionStatus: RequestStatusSuccess()));
        // Set pending state, secret message, and generate otp
        otpSessionSecretInfo
            .setSecretMessage(confirmTransactionResult.secretMessage);
        otpSessionInfo.setTransactionStatus(TransactionStatus.pending);
        _periodicallyGetTransactionInfoAndGenerateOtp(emit);
      } on Exception catch (e) {
        emit(state.copyWith(transactionActionStatus: RequestStatusFailed(e)));
      }
      _isUserRequestSubmitting = false;
    });
    on<TransactionDetailEventRejectTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        final accountData = await UserData.getCredentialAccountData();
        await authenticatorRepository.denyTransaction(
            otpSessionSecretInfo.secretId, accountData!.password);
        emit(state.copyWith(transactionActionStatus: RequestStatusSuccess()));
        // Change to failed state, clean message & stop generate otp
        otpSessionSecretInfo.clearSecretMessage();
        otpSessionInfo.setTransactionStatus(TransactionStatus.failed);
        _cancelGenerateOtp = true;
      } on Exception catch (e) {
        emit(state.copyWith(transactionActionStatus: RequestStatusFailed(e)));
      }
      _isUserRequestSubmitting = false;
    });
    on<TransactionDetailEventCancelTransaction>((event, emit) async {
      if (_isUserRequestSubmitting) return;
      _isUserRequestSubmitting = true;
      try {
        final accountData = await UserData.getCredentialAccountData();
        await authenticatorRepository.cancelTransaction(
            otpSessionSecretInfo.secretId, accountData!.password);
        emit(state.copyWith(transactionActionStatus: RequestStatusSuccess()));
        // Change to failed state, clean message & stop generate otp
        otpSessionSecretInfo.clearSecretMessage();
        otpSessionInfo.setTransactionStatus(TransactionStatus.failed);
      } on Exception catch (e) {
        emit(state.copyWith(transactionActionStatus: RequestStatusFailed(e)));
      }
      _isUserRequestSubmitting = false;
    });
  }

  // Imply timer
  _periodicallyGetTransactionInfoAndGenerateOtp(emit) {
    Timer.periodic(Duration(seconds: periodSecond), (Timer timer) {
      if (isClosed || _cancelGenerateOtp) {
        timer.cancel(); // When the stream is closed, or actively stop
        _cancelGenerateOtp = false; // Reset timer state
      } else {
        _getTransactionInfoAndGenerateOtp(emit);
      }
    });
  }

  _getTransactionInfoAndGenerateOtp(emit) async {
    try {
      await _getTransactionDetail(emit);
      _generateOtp(emit);
    } on Exception catch (e) {
      // TODO: emit error;
    }
  }

  _getTransactionDetail(emit) async {
    if (_isGetTransactionInfoSubmitting) return;
    _isGetTransactionInfoSubmitting = true;
    try {
      final getTransactionDetailResult = await authenticatorRepository
          .getTransactionDetail(otpSessionSecretInfo.secretId);
    } on Exception catch (e) {
      emit(state.copyWith(transactionActionStatus: RequestStatusFailed(e)));
    }
    _isGetTransactionInfoSubmitting = false;
  }

  _generateOtp(emit) async {
    try {
      final keyMessage = otpSessionSecretInfo.secretMessage;
      if (keyMessage == null) {
        // TODO: otp status
        _cancelGenerateOtp = true;
        return;
      }
      // Self-generation
      final otpValue = generateTOTP(keyMessage, 8, periodSecond,
          DateTime.now().millisecondsSinceEpoch, algorithm);
      // Calculate the otp remaining time
      final otpGeneratedTime = DateTime.now().millisecondsSinceEpoch;
      final otpRemainingTime = (otpGeneratedTime +
              periodSecond * Duration.millisecondsPerSecond -
              DateTime.now().millisecondsSinceEpoch) ~/
          Duration.millisecondsPerSecond;
      // Update state
      emit(state.copyWith(
          otpValueInfo: OTPValueInfo(
              value: otpValue, remainingSecond: otpRemainingTime)));
    } on Exception catch (e) {
      // TODO: otp status
    }
  }

  _updateTransactionInfoState(
      OTPSessionInfo? newOtpSessionInfo, OTPValueInfo? newOtpValueInfo) {
    if (newOtpSessionInfo != null) {
      final newTransactionStatus = newOtpSessionInfo.transactionStatus;
      switch (newTransactionStatus) {
        case TransactionStatus.requesting:
          break;
        case TransactionStatus.pending:
          break;
        case TransactionStatus.success:
          break;
        case TransactionStatus.failed:
          break;
        default:
          break;
      }
    }
  }
}
