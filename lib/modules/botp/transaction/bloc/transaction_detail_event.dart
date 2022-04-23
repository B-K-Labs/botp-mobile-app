import 'package:botp_auth/constants/transaction.dart';

abstract class TransactionDetailEvent {
  const TransactionDetailEvent();
}

// Get transaction detail
class TransactionDetailEventGetTransactionDetailAndRunSetupTimers
    extends TransactionDetailEvent {}

// Generate OTP
class TransactionDetailEventGenerateOTP extends TransactionDetailEvent {}

// Timers
class TransactionDetailEventSetupGetTransactionDetailTimer
    extends TransactionDetailEvent {}

class TransactionDetailEventSetupAndRunGenerateOTPTimer
    extends TransactionDetailEvent {}

class TransactionDetailEventCancelGetTransactionDetailTimer
    extends TransactionDetailEvent {}

class TransactionDetailEventCancelGenerateOTPTimer
    extends TransactionDetailEvent {}

// Request transaction
class TransactionDetailEventConfirmTransaction extends TransactionDetailEvent {}

class TransactionDetailEventRejectTransaction extends TransactionDetailEvent {}

class TransactionDetailEventCancelTransaction extends TransactionDetailEvent {}

// Change status temporarily
class TransactionDetailEventChangeTransactionStatusTemporarily
    extends TransactionDetailEvent {
  TransactionStatus transactionStatus;
  TransactionDetailEventChangeTransactionStatusTemporarily(
      {required this.transactionStatus});
}

// Copy
class TransactionDetailEventCopyOTP extends TransactionDetailEvent {}

class TransactionDetailEventCopyBcAddress extends TransactionDetailEvent {}
