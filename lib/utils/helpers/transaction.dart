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
    List<String>? currentTransactionSecretIdsList,
    bool isNotFetchedFirstTime = true}) {
  // Note: transactions list is always pre-sorted by time
  final bool isFilteringNewest = currentTransactionSecretIdsList != null &&
      historyTransactionSecretIdsList != null;
  // 1. Categorized list
  List<CategorizedTransactions> categorizedTransactions = [];
  List<TransactionDetail> olderTransactionsList =
      isFilteringNewest ? [] : newTransactionsList;
  // 2. History secret ids
  List<String> newHistoryTransactionSecretIdsList = [];
  // 4. Flag: Is Having new transaction flag
  bool isHavingNewTransactions = false;
  // 5. Number of incoming transactions to be notified
  List<String> notifiedTransactionsList = [];

  // Split newest transactions list and make new old transaction ids list
  if (isFilteringNewest) {
    final List<TransactionDetail> newestTransactionsList = [];
    for (var trans in newTransactionsList) {
      final transId = trans.otpSessionSecretInfo.secretId;
      // Old transactions but are marked as new
      if (historyTransactionSecretIdsList.contains(transId)) {
        newestTransactionsList.add(trans);
      }
      // Incoming transactions
      else if (!currentTransactionSecretIdsList.contains(transId) &&
          isNotFetchedFirstTime) {
        newestTransactionsList.add(trans);
        notifiedTransactionsList.add(trans.otpSessionInfo.agentName);
      }
      // Old transactions
      else {
        olderTransactionsList.add(trans);
      }
    }

    newHistoryTransactionSecretIdsList = [
      ...newestTransactionsList.map((e) => e.otpSessionSecretInfo.secretId)
    ];

    // Append to categorized list
    // - Newest
    if (newestTransactionsList.isNotEmpty) {
      categorizedTransactions.add(CategorizedTransactions(
          categoryType: TimeFilters.newest,
          transactionsList: newestTransactionsList));
      isHavingNewTransactions = true;
    }
  }

  // Categorized the rest
  // - Time ranges
  List<TimeFilters> timeFiltersList = [...TimeFilters.values];
  timeFiltersList.removeWhere(
      (element) => [TimeFilters.newest, TimeFilters.older].contains(element));
  final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
  for (var timeFilter in timeFiltersList) {
    final List<TransactionDetail> timestampFilteredTransactionsList = [];
    final List<TransactionDetail> newOlderTransactionsList = [];
    final compareTimestamp =
        currentTimestamp - timeFiltersTimeMap[timeFilter]!;
    for (var trans in olderTransactionsList) {
      // Filter by timestamp here
      if (trans.otpSessionInfo.timestamp >= compareTimestamp) {
        timestampFilteredTransactionsList.add(trans);
      } else {
        newOlderTransactionsList.add(trans);
      }
    }
    // Assign old transactions list to the new filtered one
    olderTransactionsList = newOlderTransactionsList;
    // Push new categorized transactions into the list
    if (timestampFilteredTransactionsList.isNotEmpty) {
      categorizedTransactions.add(CategorizedTransactions(
          categoryType: timeFilter,
          transactionsList: timestampFilteredTransactionsList));
    }
  }
  // - The very old transactions
  if (olderTransactionsList.isNotEmpty) {
    categorizedTransactions.add(CategorizedTransactions(
        categoryType: TimeFilters.older,
        transactionsList: olderTransactionsList));
  }

  return isFilteringNewest
      ? CategorizedTransactionsInfo(
          categorizedTransactions: categorizedTransactions,
          historyTransactionSecretIdsList: newHistoryTransactionSecretIdsList,
          isHavingNewTransactions: isHavingNewTransactions,
          notifiedTransactionsList: notifiedTransactionsList)
      : CategorizedTransactionsInfo(
          categorizedTransactions: categorizedTransactions,
          isHavingNewTransactions: isHavingNewTransactions,
          notifiedTransactionsList: notifiedTransactionsList);
}

String getBodyPushNotificationMessage(
    List<String> notifiedRequestingTransactionsList,
    List<String> notifiedWaitingTransactionsList) {
  // From agent(s)
  final List<String> agentsList = [
    notifiedRequestingTransactionsList,
    notifiedWaitingTransactionsList
  ]
      .expand((element) => element)
      .toList()
      .toSet()
      .toList(); // Combine agents lists and remove duplicated agents
  // Message concatenation
  final String leadingMessage;
  final String trailingMessage;
  // - Leading part
  if (notifiedRequestingTransactionsList.isNotEmpty &&
      notifiedWaitingTransactionsList.isNotEmpty) {
    leadingMessage =
        "You have ${notifiedRequestingTransactionsList.length} requesting and ${notifiedWaitingTransactionsList.length} waiting transactions";
  } else if (notifiedRequestingTransactionsList.isNotEmpty) {
    leadingMessage =
        "You have ${notifiedRequestingTransactionsList.length} requesting transaction${notifiedRequestingTransactionsList.length > 1 ? "s" : ""}";
  } else if (notifiedWaitingTransactionsList.isNotEmpty) {
    leadingMessage =
        "You have ${notifiedWaitingTransactionsList.length} waiting transaction${notifiedWaitingTransactionsList.length > 1 ? "s" : ""}";
  } else {
    leadingMessage = "We are listening for your upcoming transactions for you.";
  }
  // - Trailing part
  if (agentsList.length > 2) {
    trailingMessage =
        " from ${agentsList[0]}, ${agentsList[1]} and more. Click to view detail.";
  } else if (agentsList.length > 1) {
    trailingMessage =
        " from ${agentsList[0]} and ${agentsList[1]}. Click to view detail.";
  } else if (agentsList.length == 1) {
    trailingMessage = " from ${agentsList[0]}. Click to view detail.";
  } else {
    trailingMessage = "";
  }

  return leadingMessage + trailingMessage;
}
