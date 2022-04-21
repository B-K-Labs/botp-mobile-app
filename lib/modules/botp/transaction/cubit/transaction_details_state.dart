import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailsState {
  OTPInfoModel? otpInfoData;
  RequestStatus? generateOtpStatus;

  TransactionDetailsState({this.generateOtpStatus, this.otpInfoData});
  TransactionDetailsState copyWith(
          {OTPInfoModel? otpInfoData, RequestStatus? generateOtpStatus}) =>
      TransactionDetailsState(
          otpInfoData: otpInfoData ?? this.otpInfoData,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus);
}
