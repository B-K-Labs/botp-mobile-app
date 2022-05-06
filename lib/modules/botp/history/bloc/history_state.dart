import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';

class HistoryState {
  // Filter
  TransactionStatus transactionStatus;
  // // Pagination
  // PaginationInfo? paginationInfo;
  // Transactions list
  CategorizedTransactionsInfo? categorizedSucceededTransactionsInfo;
  CategorizedTransactionsInfo? categorizedFailedTransactionsInfo;
  // Status
  RequestStatus getTransactionListStatus;
  // Notifications
  List<String> notifiedSucceededTransactionsList;
  List<String> notifiedFailedTransactionsList;

  HistoryState({
    this.transactionStatus = TransactionStatus.succeeded,
    this.categorizedSucceededTransactionsInfo,
    this.categorizedFailedTransactionsInfo,
    this.notifiedSucceededTransactionsList = const [],
    this.notifiedFailedTransactionsList = const [],
    this.getTransactionListStatus = const RequestStatusInitial(),
  });

  HistoryState copyWith(
          {TransactionStatus? transactionStatus,
          CategorizedTransactionsInfo? categorizedSucceededTransactionsInfo,
          CategorizedTransactionsInfo? categorizedFailedTransactionsInfo,
          RequestStatus? getTransactionListStatus,
          List<String>? notifiedSucceededTransactionsList,
          List<String>? notifiedFailedTransactionsList}) =>
      HistoryState(
          categorizedSucceededTransactionsInfo:
              categorizedSucceededTransactionsInfo ??
                  this.categorizedSucceededTransactionsInfo,
          categorizedFailedTransactionsInfo:
              categorizedFailedTransactionsInfo ??
                  this.categorizedFailedTransactionsInfo,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus,
          notifiedSucceededTransactionsList:
              notifiedSucceededTransactionsList ??
                  this.notifiedSucceededTransactionsList,
          notifiedFailedTransactionsList: notifiedFailedTransactionsList ??
              this.notifiedFailedTransactionsList);
}
