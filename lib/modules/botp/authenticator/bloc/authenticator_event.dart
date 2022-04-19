import 'package:botp_auth/constants/transaction.dart';

abstract class AuthenticatorEvent {
  const AuthenticatorEvent();
}

class AuthenticatorEventTransactionStatusChanged extends AuthenticatorEvent {
  TransactionStatus transactionStatus;

  AuthenticatorEventTransactionStatusChanged({required this.transactionStatus});
}

class AuthenticatorEventPaginationChanged extends AuthenticatorEvent {
  int totalPages;
  int currentPage;

  AuthenticatorEventPaginationChanged(
      {required this.totalPages, required this.currentPage});

  AuthenticatorEventPaginationChanged copyWith(
          {int? totalPages, int? currentPage}) =>
      AuthenticatorEventPaginationChanged(
          totalPages: totalPages ?? this.totalPages,
          currentPage: currentPage ?? this.currentPage);
}
