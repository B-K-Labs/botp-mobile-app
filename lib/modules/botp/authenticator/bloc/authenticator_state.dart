import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/constants/transaction.dart';

class AuthenticatorState {
  // Filter
  TransactionStatus transactionStatus;
  // Pagination
  int totalPages;
  int currentPage;
  // Transactions list
  List<TransactionDetail> transactionsList;
  RequestStatus getTransactionListStatus;

  AuthenticatorState(
      {this.transactionStatus = TransactionStatus.requesting,
      this.totalPages = 1,
      this.currentPage = kTransactionItemsPagSize,
      this.transactionsList = const [],
      this.getTransactionListStatus = const RequestStatusInitial()});

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          int? totalPages,
          int? currentPage,
          List<TransactionDetail>? transactionsList,
          RequestStatus? getTransactionListStatus}) =>
      AuthenticatorState(
          transactionStatus: transactionStatus ?? this.transactionStatus,
          totalPages: totalPages ?? this.totalPages,
          currentPage: currentPage ?? this.currentPage,
          transactionsList: transactionsList ?? this.transactionsList,
          getTransactionListStatus:
              getTransactionListStatus ?? this.getTransactionListStatus);
}
