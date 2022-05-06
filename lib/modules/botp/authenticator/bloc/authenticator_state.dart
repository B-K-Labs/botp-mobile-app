import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';

class AuthenticatorState {
  // Filter
  TransactionStatus transactionStatus;
  // // Pagination
  // PaginationInfo? paginationInfo;
  // Transactions list
  CategorizedTransactionsInfo? categorizedRequestingTransactionsInfo;
  CategorizedTransactionsInfo? categorizedWaitingTransactionsInfo;
  // Status
  RequestStatus getTransactionListStatus;
  // Notifications
  List<String> notifiedRequestingTransactionsList;
  List<String> notifiedWaitingTransactionsList;

  AuthenticatorState({
    this.transactionStatus = TransactionStatus.requesting,
    this.categorizedRequestingTransactionsInfo,
    this.categorizedWaitingTransactionsInfo,
    this.notifiedRequestingTransactionsList = const [],
    this.notifiedWaitingTransactionsList = const [],
    this.getTransactionListStatus = const RequestStatusInitial(),
  });

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          CategorizedTransactionsInfo? categorizedRequestingTransactionsInfo,
          CategorizedTransactionsInfo? categorizedWaitingTransactionsInfo,
          RequestStatus? getTransactionListStatus,
          List<String>? notifiedRequestingTransactionsList,
          List<String>? notifiedWaitingTransactionsList}) =>
      AuthenticatorState(
          categorizedRequestingTransactionsInfo:
              categorizedRequestingTransactionsInfo ??
                  this.categorizedRequestingTransactionsInfo,
          categorizedWaitingTransactionsInfo:
              categorizedWaitingTransactionsInfo ??
                  this.categorizedWaitingTransactionsInfo,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus,
          notifiedRequestingTransactionsList:
              notifiedRequestingTransactionsList ??
                  this.notifiedRequestingTransactionsList,
          notifiedWaitingTransactionsList: notifiedWaitingTransactionsList ??
              this.notifiedWaitingTransactionsList);
}
