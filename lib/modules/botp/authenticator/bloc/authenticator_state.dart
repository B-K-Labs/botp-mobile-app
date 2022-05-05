import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';

class AuthenticatorState {
  // Filter
  TransactionStatus transactionStatus;
  // Pagination
  PaginationInfo? paginationInfo;
  // Transactions list
  CategorizedTransactionsInfo? categorizedTransactionsInfo;
  RequestStatus getTransactionListStatus;

  AuthenticatorState(
      {this.transactionStatus = TransactionStatus.requesting,
      this.paginationInfo,
      this.categorizedTransactionsInfo,
      this.getTransactionListStatus = const RequestStatusInitial()});

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          PaginationInfo? paginationInfo,
          CategorizedTransactionsInfo? categorizedTransactionsInfo,
          RequestStatus? getTransactionListStatus}) =>
      AuthenticatorState(
          paginationInfo: paginationInfo ?? this.paginationInfo,
          categorizedTransactionsInfo:
              categorizedTransactionsInfo ?? this.categorizedTransactionsInfo,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus);
}
