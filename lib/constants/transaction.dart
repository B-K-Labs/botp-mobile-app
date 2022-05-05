enum TransactionStatus {
  requesting,
  waiting, // Updated 27/04/2022
  succeeded,
  failed,
  all,
}

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
const otpDigits = 7;
const otpPeriodSecond = 120;
const otpAlgorithm = "SHA-512";

// Socket simulation
const socketPeriodSecond = 10;

// Filter
enum TimeFilters {
  newest,
  lastHour,
  lastDay,
  lastWeek,
  lastMonth,
  lastYear,
  older,
}

const Map<TimeFilters, int> timeFiltersTimeMap = {
  TimeFilters.newest: 0,
  TimeFilters.lastHour: Duration.millisecondsPerHour,
  TimeFilters.lastDay: Duration.millisecondsPerDay,
  TimeFilters.lastWeek: Duration.millisecondsPerDay * 7,
  TimeFilters.lastMonth: Duration.millisecondsPerDay * 30,
  TimeFilters.lastYear: Duration.millisecondsPerDay * 365,
  TimeFilters.older: 0,
};

const Map<TimeFilters, String> timeFiltersNameMap = {
  TimeFilters.newest: "Newest",
  TimeFilters.lastHour: "Last hour",
  TimeFilters.lastDay: "Last day",
  TimeFilters.lastWeek: "Last week",
  TimeFilters.lastMonth: "Last month",
  TimeFilters.lastYear: "Last year",
  TimeFilters.older: "Older",
};
