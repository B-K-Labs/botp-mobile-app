import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/transaction.dart';

DateTime dateTimeFromSecondsSinceEpoch(String millisecondsSinceEpoch) =>
    DateTime.fromMillisecondsSinceEpoch(int.parse(millisecondsSinceEpoch));

String shortenNotifyMessage(String notifyMessage) {
  // Example: "[khiem20tc] Facebook need your confirmation to your account password" would be
  // "[khiem20tc] Facebook need your confirmation to you..."
  final String puredNotifyMessage =
      notifyMessage.replaceAll("\n", "").replaceAll("\t", "");
  const int maxLength = 35;
  return puredNotifyMessage.length > maxLength
      ? puredNotifyMessage.replaceRange(
          maxLength, puredNotifyMessage.length, '...')
      : puredNotifyMessage;
}

// Helper function
CategorizedTransactionsInfo categorizeTransactions(
    List<TransactionDetail> newTransactionsList,
    List<String> oldTransactionSecretIdsList) {
  List<CategorizedTransactions> _categorizedTransactions = [];
  // Note: both old and new transactions list are pre-sorted by time
  final List<TransactionDetail> _newestTransactionsList = [];
  List<TransactionDetail> _olderTransactionsList = [];

  // Split newest transactions list and make new old transaction ids list
  for (var trans in newTransactionsList) {
    if (oldTransactionSecretIdsList
        .contains(trans.otpSessionSecretInfo.secretId)) {
      _olderTransactionsList.add(trans);
    } else {
      _newestTransactionsList.add(trans);
    }
  }
  final _newOldTransactionSecretIdsList = [
    ..._olderTransactionsList.map((e) => e.otpSessionSecretInfo.secretId)
  ];

  // Append the new categorized transaction into the list
  // 1. Newest
  if (_newestTransactionsList.isNotEmpty) {
    _categorizedTransactions.add(CategorizedTransactions(
        categoryType: TimeFilters.newest,
        transactionsList: _newestTransactionsList));
  }

  // 2. Time ranges
  List<TimeFilters> timeFiltersList = [...TimeFilters.values];
  timeFiltersList.removeWhere(
      (element) => [TimeFilters.newest, TimeFilters.older].contains(element));
  final _currentTimestamp = DateTime.now().millisecondsSinceEpoch;
  for (var timeFilter in timeFiltersList) {
    final List<TransactionDetail> _timestampFilteredTransactionsList = [];
    final List<TransactionDetail> _newOlderTransactionsList = [];
    final _compareTimestamp =
        _currentTimestamp - timeFiltersTimeMap[timeFilter]!;
    for (var trans in _olderTransactionsList) {
      // Filter by timestamp here
      if (trans.otpSessionInfo.timestamp >= _compareTimestamp) {
        _timestampFilteredTransactionsList.add(trans);
      } else {
        _newOlderTransactionsList.add(trans);
      }
    }
    // Assign old transactions list to the new filtered one
    _olderTransactionsList = _newOlderTransactionsList;
    // Push new categorized transactions into the list
    if (_timestampFilteredTransactionsList.isNotEmpty) {
      _categorizedTransactions.add(CategorizedTransactions(
          categoryType: timeFilter,
          transactionsList: _timestampFilteredTransactionsList));
    }
  }
  // 3. The very old transactions
  if (_olderTransactionsList.isNotEmpty) {
    _categorizedTransactions.add(CategorizedTransactions(
        categoryType: TimeFilters.older,
        transactionsList: _olderTransactionsList));
  }

  return CategorizedTransactionsInfo(
      categorizedTransactions: _categorizedTransactions,
      transactionSecretIdsList: _newOldTransactionSecretIdsList);
}
