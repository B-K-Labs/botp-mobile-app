import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailState {
  OTPValueInfo? otpValueInfo;
  RequestStatus? generateOtpStatus;

  TransactionDetailState({this.generateOtpStatus, this.otpValueInfo});
  TransactionDetailState copyWith(
          {OTPValueInfo? otpValueInfo, RequestStatus? generateOtpStatus}) =>
      TransactionDetailState(
          otpValueInfo: otpValueInfo ?? this.otpValueInfo,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus);
}
