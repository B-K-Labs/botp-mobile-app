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
    {required List<TransactionDetail> newTransactionsList,
    List<String>? historyTransactionSecretIdsList,
    List<String>? currentTransactionSecretIdsList}) {
  // Note: transactions list is always pre-sorted by time
  final bool isFilteringNewest = currentTransactionSecretIdsList != null &&
      historyTransactionSecretIdsList != null;
  // 1. Categorized list
  List<CategorizedTransactions> _categorizedTransactions = [];
  List<TransactionDetail> _olderTransactionsList =
      isFilteringNewest ? [] : newTransactionsList;
  // 2. History secret ids
  List<String> _newHistoryTransactionSecretIdsList = [];
  // 3. All secret ids
  List<String> _allTransactionSecretIdsList =
      newTransactionsList.map((e) => e.otpSessionSecretInfo.secretId).toList();
  // 4. Has new notification
  bool hasNewNotification = false;

  // Split newest transactions list and make new old transaction ids list
  if (isFilteringNewest) {
    final List<TransactionDetail> _newestTransactionsList = [];
    for (var trans in newTransactionsList) {
      final transId = trans.otpSessionSecretInfo.secretId;
      if (historyTransactionSecretIdsList.contains(transId) ||
          !currentTransactionSecretIdsList.contains(transId)) {
        _newestTransactionsList.add(trans);
      } else {
        _olderTransactionsList.add(trans);
      }
    }

    _newHistoryTransactionSecretIdsList = [
      ..._newestTransactionsList.map((e) => e.otpSessionSecretInfo.secretId)
    ];

    // Append to categorized list
    // - Newest
    if (_newestTransactionsList.isNotEmpty) {
      _categorizedTransactions.add(CategorizedTransactions(
          categoryType: TimeFilters.newest,
          transactionsList: _newestTransactionsList));
      hasNewNotification = true;
    }
  }

  // Categorized the rest
  // - Time ranges
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
  // - The very old transactions
  if (_olderTransactionsList.isNotEmpty) {
    _categorizedTransactions.add(CategorizedTransactions(
        categoryType: TimeFilters.older,
        transactionsList: _olderTransactionsList));
  }

  return isFilteringNewest
      ? CategorizedTransactionsInfo(
          categorizedTransactions: _categorizedTransactions,
          allTransactionSecretIdsList: _allTransactionSecretIdsList,
          historyTransactionSecretIdsList: _newHistoryTransactionSecretIdsList,
          hasNewNotification: hasNewNotification)
      : CategorizedTransactionsInfo(
          categorizedTransactions: _categorizedTransactions,
          hasNewNotification: hasNewNotification);
}
