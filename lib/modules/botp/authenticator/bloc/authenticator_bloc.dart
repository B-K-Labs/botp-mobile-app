import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class AuthenticatorBloc extends Bloc<AuthenticatorEvent, AuthenticatorState> {
  AuthenticatorRepository authenticatorRepository;
  // Pagination
  int page;
  int size;
  // Timer
  Timer? _getTransactionsListTimer;
  // Lock
  bool _isGettingTransactionsListSubmitting = false;
  bool _isGettingTransactionsListTimerRunning = false;

  AuthenticatorBloc(
      {required this.authenticatorRepository,
      this.page = 1,
      this.size = kTransactionItemsPagSize})
      : super(AuthenticatorState()) {
    on<AuthenticatorEventTransactionStatusChanged>((event, emit) =>
        emit(state.copyWith(transactionStatus: event.transactionStatus)));

    on<AuthenticatorEventPaginationChanged>((event, emit) => emit(
        state.copyWith(
            paginationInfo: PaginationInfo(
                currentPage: event.currentPage,
                totalPage: state.paginationInfo!.totalPage))));

    on<AuthenticatorEventGetTransactionsListAndSetupTimer>((event, emit) async {
      if (_isGettingTransactionsListSubmitting) return;
      _isGettingTransactionsListSubmitting = true;
      final accountData = await UserData.getCredentialAccountData();
      emit(state.copyWith(getTransactionListStatus: RequestStatusSubmitting()));
      try {
        final getTransactionListResult =
            await authenticatorRepository.getTransactionsList(
                accountData!.bcAddress, state.transactionStatus);
        emit(state.copyWith(
            paginationInfo: getTransactionListResult.paginationInfo,
            transactionsList: getTransactionListResult.transactionsList,
            getTransactionListStatus: RequestStatusSuccess()));

        // Setup timer
        add(AuthenticatorEventSetupGetTransactionsListTimer());
      } on Exception catch (e) {
        emit(state.copyWith(getTransactionListStatus: RequestStatusFailed(e)));
      }
      emit(state.copyWith(
          getTransactionListStatus: const RequestStatusInitial()));
      _isGettingTransactionsListSubmitting = false;
    });

    on<AuthenticatorEventSetupGetTransactionsListTimer>((event, emit) async {
      if (_isGettingTransactionsListTimerRunning) return;
      _isGettingTransactionsListTimerRunning = true;
      _getTransactionsListTimer = Timer.periodic(
          const Duration(seconds: socketPeriodSecond), (Timer timer) {
        if (isClosed || !_isGettingTransactionsListTimerRunning) {
          // Cancel timer
          _cancelGetTransactionsListTimer();
        } else {
          add(AuthenticatorEventGetTransactionsListAndSetupTimer());
        }
      });
    });
  }

  _cancelGetTransactionsListTimer() {
    _getTransactionsListTimer?.cancel();
    _getTransactionsListTimer = null;
    _isGettingTransactionsListTimerRunning = false;
  }

  refreshTransactionsList() async {
    _cancelGetTransactionsListTimer();
    add(AuthenticatorEventGetTransactionsListAndSetupTimer());
    await stream.first; // Submitting
    await stream.first; // Success
  }
}
