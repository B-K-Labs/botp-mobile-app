abstract class TransactionStatus {
  const TransactionStatus();
}

class TransactionStatusRequesting extends TransactionStatus {}

class TransactionStatusPending extends TransactionStatus {}

class TransactionStatusSuccess extends TransactionStatus {}

class TransactionStatusFailed extends TransactionStatus {}

class TransactionStatusAll extends TransactionStatus {}
