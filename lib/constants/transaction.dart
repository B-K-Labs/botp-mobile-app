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

enum OTPValueStatus {
  initial,
  valid,
  nearlyExpired,
  expired,
  notAvailable,
}

enum TransactionRequestAction {
  confirm,
  deny,
  cancel,
}

// OTP threshold
const otpRemainingSecondThreshold = 3.0;

// OTP generator
const otpDigits = 8;
const otpPeriodSecond = 120;
const otpAlgorithm = "SHA-512";

// Socket simulation
const socketPeriodSecond = 10;
