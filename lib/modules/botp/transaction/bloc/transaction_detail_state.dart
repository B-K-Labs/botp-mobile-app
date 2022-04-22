import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailState {
  OTPSessionInfo otpSessionInfo;
  OTPValueInfo otpValueInfo;
  RequestStatus? transactionActionStatus;

  TransactionDetailState({
    required this.otpSessionInfo,
    required this.otpValueInfo,
    this.transactionActionStatus,
  });
  TransactionDetailState copyWith(
          {OTPValueInfo? otpValueInfo,
          OTPSessionInfo? otpSessionInfo,
          RequestStatus? transactionActionStatus}) =>
      TransactionDetailState(
          otpValueInfo: otpValueInfo ?? this.otpValueInfo,
          otpSessionInfo: otpSessionInfo ?? this.otpSessionInfo,
          transactionActionStatus:
              transactionActionStatus ?? this.transactionActionStatus);
}
