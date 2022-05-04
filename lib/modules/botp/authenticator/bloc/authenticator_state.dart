import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';

class AuthenticatorState {
  // Filter
  TransactionStatus transactionStatus;
  // Pagination
  PaginationInfo? paginationInfo;
  // Transactions list
  List<CategorizedTransactions>? categorizedTransactionsList;
  RequestStatus getTransactionListStatus;

  AuthenticatorState(
      {this.transactionStatus = TransactionStatus.all,
      this.paginationInfo,
      this.categorizedTransactionsList,
      this.getTransactionListStatus = const RequestStatusInitial()});

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          PaginationInfo? paginationInfo,
          List<CategorizedTransactions>? categorizedTransactionsList,
          RequestStatus? getTransactionListStatus}) =>
      AuthenticatorState(
          paginationInfo: paginationInfo ?? this.paginationInfo,
          categorizedTransactionsList:
              categorizedTransactionsList ?? this.categorizedTransactionsList,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus);
}
