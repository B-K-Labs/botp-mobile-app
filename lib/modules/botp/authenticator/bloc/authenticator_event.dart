import 'package:botp_auth/constants/transaction.dart';

abstract class AuthenticatorEvent {
  const AuthenticatorEvent();
}

class AuthenticatorEventTransactionStatusChanged extends AuthenticatorEvent {
  final TransactionStatus transactionStatus;

  AuthenticatorEventTransactionStatusChanged({required this.transactionStatus});
}

class AuthenticatorEventRemoveTransactionHistory extends AuthenticatorEvent {
  final String transactionSecretId;
  final TransactionStatus transactionStatus;

  AuthenticatorEventRemoveTransactionHistory(
      {required this.transactionSecretId, required this.transactionStatus});
}

class AuthenticatorEventPaginationChanged extends AuthenticatorEvent {
  final int currentPage;

  AuthenticatorEventPaginationChanged({this.currentPage = 1});
}

class AuthenticatorEventGetTransactionsListAndSetupTimer
    extends AuthenticatorEvent {
  final TransactionStatus? transactionStatus;
  final bool? needMorePage;

  AuthenticatorEventGetTransactionsListAndSetupTimer(
      {this.transactionStatus, this.needMorePage});
}

class AuthenticatorEventSetupGetTransactionsListTimer
    extends AuthenticatorEvent {}
