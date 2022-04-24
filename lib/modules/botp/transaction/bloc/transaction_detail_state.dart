import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailState {
  OTPSessionInfo? otpSessionInfo;
  OTPValueInfo otpValueInfo;
  RequestStatus? userRequestStatus;
  RequestStatus? getTransactionDetailStatus;
  RequestStatus? generateOtpStatus;

  TransactionDetailState({
    this.otpSessionInfo,
    required this.otpValueInfo,
    this.userRequestStatus = const RequestStatusInitial(),
    this.getTransactionDetailStatus = const RequestStatusInitial(),
    this.generateOtpStatus = const RequestStatusInitial(),
  });
  TransactionDetailState copyWith({
    OTPValueInfo? otpValueInfo,
    OTPSessionInfo? otpSessionInfo,
    RequestStatus? userRequestStatus,
    RequestStatus? getTransactionDetailStatus,
    RequestStatus? generateOtpStatus,
  }) =>
      TransactionDetailState(
        otpValueInfo: otpValueInfo ?? this.otpValueInfo,
        otpSessionInfo: otpSessionInfo ?? this.otpSessionInfo,
        userRequestStatus: userRequestStatus ?? this.userRequestStatus,
        getTransactionDetailStatus:
            getTransactionDetailStatus ?? this.getTransactionDetailStatus,
        generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus,
      );
}
