import 'package:botp_auth/constants/transaction.dart';

abstract class TransactionDetailEvent {
  const TransactionDetailEvent();
}

// Get transaction detail
class TransactionDetailEventGetTransactionDetailAndRunSetupTimers
    extends TransactionDetailEvent {}

// Generate OTP
class TransactionDetailEventGenerateOTPAndSetupTimer
    extends TransactionDetailEvent {}

// Timers
class TransactionDetailEventSetupGetTransactionDetailTimer
    extends TransactionDetailEvent {}

class TransactionDetailEventSetupGenerateOTPTimer
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
