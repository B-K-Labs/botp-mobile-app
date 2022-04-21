enum TransactionStatus {
  requesting,
  pending,
  success,
  failed,
}

enum TransactionStatusSize { normal, small }

extension ToType on TransactionStatus {
  String toCapitalizedString() {
    final rawTypeString = toString().split('.').last;
    return '${rawTypeString[0].toUpperCase()}${rawTypeString.substring(1)}';
  }
}
