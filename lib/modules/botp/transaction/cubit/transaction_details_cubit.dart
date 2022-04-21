import 'dart:async';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/modules/botp/transaction/cubit/transaction_details_state.dart';
import 'package:botp_auth/utils/services/crypto_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsCubit extends Cubit<TransactionDetailsState> {
  AuthenticatorRepository authenticatorRepository;
  final period = 1;
  Timer? timer;

  TransactionDetailsCubit({required this.authenticatorRepository})
      : super(TransactionDetailsState()) {
    // Set interval
    trackOtp();
    Timer.periodic(Duration(seconds: period), (Timer timer) {
      if (isClosed) {
        print("Stop generate OTP");
        timer.cancel();
      } else {
        trackOtp();
      }
    });
  }

  trackOtp() {
    generateOtp();
    print("OTP Generated");
  }

  generateOtp() async {
    emit(state.copyWith(generateOtpStatus: RequestStatusSubmitting()));
    try {
      // Self-generation
      final otp = generateTOTP("secret message", 8, period,
          DateTime.now().millisecondsSinceEpoch, "SHA-512");
      // Caculate the otp remaining time
      final otpGeneratedTime = DateTime.now().millisecondsSinceEpoch;
      final remainingTime = (otpGeneratedTime +
              period * Duration.millisecondsPerSecond -
              DateTime.now().millisecondsSinceEpoch) ~/
          Duration.millisecondsPerSecond;
      emit(state.copyWith(otp: otp, otpRemaingTime: remainingTime));
    } on Exception catch (e) {
      emit(state.copyWith(generateOtpStatus: RequestStatusFailed(e)));
    }
  }
  // This page no need to dispatch any actions/events
}
