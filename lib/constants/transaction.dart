enum TransactionStatus {
  requesting,
  pending,
  success,
  failed,
  all,
}

enum TransactionStatusSize { normal, small }

extension ToType on TransactionStatus {
  String toCapitalizedString() {
    final rawTypeString = toString().split('.').last;
    return '${rawTypeString[0].toUpperCase()}${rawTypeString.substring(1)}';
  }
}

extension ToTransactionStatusType on String {
  TransactionStatus toTransactionStatusType() {
    return TransactionStatus.values
        .firstWhere((e) => e.name.toString().toLowerCase() == toLowerCase());
  }
}

enum TransactionRequestAction {
  confirm,
  deny,
  cancel,
}
