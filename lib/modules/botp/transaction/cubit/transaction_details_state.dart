import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailsState {
  OTPInfoModel? otpInfo;
  RequestStatus? generateOtpStatus;

  TransactionDetailsState({this.generateOtpStatus, this.otpInfo});
  TransactionDetailsState copyWith(
          {OTPInfoModel? otpInfo, RequestStatus? generateOtpStatus}) =>
      TransactionDetailsState(
          otpInfo: otpInfo ?? this.otpInfo,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus);
}
