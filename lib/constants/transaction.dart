enum TransactionStatus {
  requesting,
  pending,
  success,
  failed,
}

enum TransactionStatusSize { normal, small }

extension ParseToString on TransactionStatus {
  String toStringType() {
    final rawTypeString = toString().split('.').last;
    return '${rawTypeString[0].toUpperCase()}${rawTypeString.substring(1)}';
  }
}
