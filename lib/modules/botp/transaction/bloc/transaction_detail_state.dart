import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailState {
  OTPSessionInfo? otpSessionInfo;
  OTPValueInfo otpValueInfo;
  RequestStatus? userRequestStatus;
  RequestStatus? getTransactionDetailStatus;

  TransactionDetailState({
    this.otpSessionInfo,
    required this.otpValueInfo,
    this.userRequestStatus = const RequestStatusInitial(),
    this.getTransactionDetailStatus = const RequestStatusInitial(),
  });
  TransactionDetailState copyWith({
    OTPValueInfo? otpValueInfo,
    OTPSessionInfo? otpSessionInfo,
    RequestStatus? userRequestStatus,
    RequestStatus? getTransactionDetailStatus,
  }) =>
      TransactionDetailState(
        otpValueInfo: otpValueInfo ?? this.otpValueInfo,
        otpSessionInfo: otpSessionInfo ?? this.otpSessionInfo,
        userRequestStatus: userRequestStatus ?? this.userRequestStatus,
        getTransactionDetailStatus:
            getTransactionDetailStatus ?? this.getTransactionDetailStatus,
      );
}
