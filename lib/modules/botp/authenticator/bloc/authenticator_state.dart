import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/transaction.dart';

class AuthenticatorState {
  // Filter
  TransactionStatus? transactionStatus;
  // Pagination
  PaginationInfo? paginationInfo;
  // Transactions list
  List<TransactionDetail>? transactionsList;
  RequestStatus getTransactionListStatus;

  AuthenticatorState(
      {this.transactionStatus,
      this.paginationInfo,
      this.transactionsList,
      this.getTransactionListStatus = const RequestStatusInitial()});

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          PaginationInfo? paginationInfo,
          List<TransactionDetail>? transactionsList,
          RequestStatus? getTransactionListStatus}) =>
      AuthenticatorState(
          paginationInfo: paginationInfo ?? this.paginationInfo,
          transactionsList: transactionsList ?? this.transactionsList,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus);
}
