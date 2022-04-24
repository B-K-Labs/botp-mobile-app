import 'package:botp_auth/constants/transaction.dart';

abstract class AuthenticatorEvent {
  const AuthenticatorEvent();
}

class AuthenticatorEventTransactionStatusChanged extends AuthenticatorEvent {
  TransactionStatus? transactionStatus;

  AuthenticatorEventTransactionStatusChanged({this.transactionStatus});
}

class AuthenticatorEventPaginationChanged extends AuthenticatorEvent {
  int currentPage;

  AuthenticatorEventPaginationChanged({this.currentPage = 1});
}

class AuthenticatorEventGetTransactionsListAndSetupTimer
    extends AuthenticatorEvent {}

class AuthenticatorEventSetupGetTransactionsListTimer
    extends AuthenticatorEvent {}
