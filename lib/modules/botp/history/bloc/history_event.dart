import 'package:botp_auth/constants/transaction.dart';

abstract class HistoryEvent {
  const HistoryEvent();
}

class HistoryEventTransactionStatusChanged extends HistoryEvent {
  final TransactionStatus transactionStatus;

  HistoryEventTransactionStatusChanged({required this.transactionStatus});
}

class HistoryEventPaginationChanged extends HistoryEvent {
  final int currentPage;

  HistoryEventPaginationChanged({this.currentPage = 1});
}

class HistoryEventGetTransactionsListAndSetupTimer extends HistoryEvent {
  final TransactionStatus? transactionStatus;
  final bool? needMorePage;

  HistoryEventGetTransactionsListAndSetupTimer(
      {this.transactionStatus, this.needMorePage});
}

class HistoryEventSetupGetTransactionsListTimer extends HistoryEvent {}
