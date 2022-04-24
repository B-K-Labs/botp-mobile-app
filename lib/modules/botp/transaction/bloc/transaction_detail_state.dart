import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';

class TransactionDetailState {
  final OTPSessionInfo? otpSessionInfo;
  final OTPValueInfo otpValueInfo;
  // Request operations
  final RequestStatus userRequestStatus;
  final RequestStatus getTransactionDetailStatus;
  final RequestStatus generateOtpStatus;
  // Set clip board
  final SetClipboardStatus copyBcAddressStatus;
  final SetClipboardStatus copyOtpStatus;

  TransactionDetailState({
    this.otpSessionInfo,
    required this.otpValueInfo,
    this.userRequestStatus = const RequestStatusInitial(),
    this.getTransactionDetailStatus = const RequestStatusInitial(),
    this.generateOtpStatus = const RequestStatusInitial(),
    this.copyBcAddressStatus = const SetClipboardStatusInitial(),
    this.copyOtpStatus = const SetClipboardStatusInitial(),
  });
  TransactionDetailState copyWith({
    OTPValueInfo? otpValueInfo,
    OTPSessionInfo? otpSessionInfo,
    RequestStatus? userRequestStatus,
    RequestStatus? getTransactionDetailStatus,
    RequestStatus? generateOtpStatus,
    SetClipboardStatus? copyBcAddressStatus,
    SetClipboardStatus? copyOtpStatus,
  }) =>
      TransactionDetailState(
          otpValueInfo: otpValueInfo ?? this.otpValueInfo,
          otpSessionInfo: otpSessionInfo ?? this.otpSessionInfo,
          userRequestStatus: userRequestStatus ?? this.userRequestStatus,
          getTransactionDetailStatus:
              getTransactionDetailStatus ?? this.getTransactionDetailStatus,
          generateOtpStatus: generateOtpStatus ?? this.generateOtpStatus,
          copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus,
          copyOtpStatus: copyOtpStatus ?? this.copyOtpStatus);
}
