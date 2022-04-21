import 'package:botp_auth/constants/transaction.dart';

abstract class AuthenticatorEvent {
  const AuthenticatorEvent();
}

class AuthenticatorEventTransacionStatusChanged extends AuthenticatorEvent {
  TransactionStatus? transactionStatus;

  AuthenticatorEventTransacionStatusChanged({this.transactionStatus});
}

class AuthenticatorEventPaginationChanged extends AuthenticatorEvent {
  int currentPage;

  AuthenticatorEventPaginationChanged({this.currentPage = 1});
}

class AuthenticatorEventGetTransactionsList extends AuthenticatorEvent {}
