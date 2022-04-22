abstract class TransactionDetailEvent {
  const TransactionDetailEvent();
}

// Init state: get transaction detail and set interval for otp generator (if pending)
class TransactionDetailEventInitState extends TransactionDetailEvent {}

// Get transaction detail
class TransactionDetailEventGetInfo extends TransactionDetailEvent {}

// Request transaction
class TransactionDetailEventConfirmTransaction extends TransactionDetailEvent {}

class TransactionDetailEventRejectTransaction extends TransactionDetailEvent {}

class TransactionDetailEventCancelTransaction extends TransactionDetailEvent {}

// Copy bcAddress
class TransactionDetailEventCopyBcAddress extends TransactionDetailEvent {}
