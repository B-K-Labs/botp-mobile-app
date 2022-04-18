import 'dart:async';
import 'package:botp_auth/common/repositories/history_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/modules/botp/transaction/cubit/transaction_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsCubit extends Cubit<TransactionDetailsState> {
  HistoryRepository historyRepository;
  final period = 4;
  Timer? timer;

  TransactionDetailsCubit({required this.historyRepository})
      : super(TransactionDetailsState()) {
    // Set interval
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
      final generateOtpResult = await historyRepository.generateOtp(
          "priavteMessageForOtpGeneration", period, 8);

      // Caculate the otp remaining time
      final otpGeneratedTime = generateOtpResult.generatedTime;
      final remainingTime = (otpGeneratedTime +
              period * Duration.millisecondsPerSecond -
              DateTime.now().millisecondsSinceEpoch) ~/
          Duration.millisecondsPerSecond;
      emit(state.copyWith(
          otp: generateOtpResult.otp, otpRemaingTime: remainingTime));
    } on Exception catch (e) {
      emit(state.copyWith(generateOtpStatus: RequestStatusFailed(e)));
    }
  }
  // This page no need to dispatch any actions/events
}
