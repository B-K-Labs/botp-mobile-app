import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailState {
  OTPSessionInfo otpSessionInfo;
  OTPValueInfo otpValueInfo;
  RequestStatus? generateOtpStatus;

  TransactionDetailState({
    required this.otpSessionInfo,
    required this.otpValueInfo,
    this.generateOtpStatus,
  });
  TransactionDetailState copyWith(
          {OTPValueInfo? otpValueInfo,
          OTPSessionInfo? otpSessionInfo,
          RequestStatus? generateOtpStatus}) =>
      TransactionDetailState(
          otpValueInfo: otpValueInfo ?? this.otpValueInfo,
          otpSessionInfo: otpSessionInfo ?? this.otpSessionInfo,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus);
}
