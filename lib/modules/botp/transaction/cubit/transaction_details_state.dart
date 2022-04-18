import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailsState {
  String? otp;
  int? otpRemaingTime;

  RequestStatus? generateOtpStatus;

  TransactionDetailsState(
      {this.otp, this.otpRemaingTime, this.generateOtpStatus});
  TransactionDetailsState copyWith(
          {String? otp,
          int? otpRemaingTime,
          RequestStatus? generateOtpStatus}) =>
      TransactionDetailsState(
          otp: otp ?? this.otp,
          otpRemaingTime: otpRemaingTime ?? this.otpRemaingTime,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus);
}
