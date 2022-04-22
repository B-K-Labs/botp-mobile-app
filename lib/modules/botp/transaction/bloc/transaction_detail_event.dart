abstract class TransactionDetailEvent {
  const TransactionDetailEvent();
}

// Get transaction detail
class TransactionDetailEventGetTransactionDetailAndSetupTimer
    extends TransactionDetailEvent {}

// Request transaction
class TransactionDetailEventConfirmTransaction extends TransactionDetailEvent {}

class TransactionDetailEventRejectTransaction extends TransactionDetailEvent {}

class TransactionDetailEventCancelTransaction extends TransactionDetailEvent {}

// Copy bcAddress
class TransactionDetailEventCopyBcAddress extends TransactionDetailEvent {}
