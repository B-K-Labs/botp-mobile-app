import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailsState {
  OTPValueInfo? otpValueInfo;
  RequestStatus? generateOtpStatus;

  TransactionDetailsState({this.generateOtpStatus, this.otpValueInfo});
  TransactionDetailsState copyWith(
          {OTPValueInfo? otpValueInfo, RequestStatus? generateOtpStatus}) =>
      TransactionDetailsState(
          otpValueInfo: otpValueInfo ?? this.otpValueInfo,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus);
}
