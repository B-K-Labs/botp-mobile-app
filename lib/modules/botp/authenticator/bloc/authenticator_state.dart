import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/constants/transaction.dart';

class AuthenticatorState {
  TransactionStatus transactionStatus;
  int totalPages;
  int currentPage;

  AuthenticatorState(
      {this.transactionStatus = TransactionStatus.requesting,
      this.totalPages = 1,
      this.currentPage = transactionsPagSize});

  AuthenticatorState copyWith(
          {TransactionStatus? transactionStatus,
          int? totalPages,
          int? currentPage}) =>
      AuthenticatorState(
          transactionStatus: transactionStatus ?? this.transactionStatus,
          totalPages: totalPages ?? this.totalPages,
          currentPage: currentPage ?? this.currentPage);
}
