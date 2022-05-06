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

  AuthenticatorState({
    this.transactionStatus = TransactionStatus.requesting,
    this.categorizedRequestingTransactionsInfo,
    this.categorizedWaitingTransactionsInfo,
    this.getTransactionListStatus = const RequestStatusInitial(),
  });

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          CategorizedTransactionsInfo? categorizedRequestingTransactionsInfo,
          CategorizedTransactionsInfo? categorizedWaitingTransactionsInfo,
          RequestStatus? getTransactionListStatus}) =>
      AuthenticatorState(
          categorizedRequestingTransactionsInfo:
              categorizedRequestingTransactionsInfo ??
                  this.categorizedRequestingTransactionsInfo,
          categorizedWaitingTransactionsInfo:
              categorizedWaitingTransactionsInfo ??
                  this.categorizedWaitingTransactionsInfo,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus);
}
