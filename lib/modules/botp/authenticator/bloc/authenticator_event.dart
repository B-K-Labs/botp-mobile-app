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
    extends AuthenticatorEvent {
  final TransactionStatus? transactionStatus;

  AuthenticatorEventGetTransactionsListAndSetupTimer({this.transactionStatus});
}

class AuthenticatorEventSetupGetTransactionsListTimer
    extends AuthenticatorEvent {}
