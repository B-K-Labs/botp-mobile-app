import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/history/bloc/history_event.dart';
import 'package:botp_auth/modules/botp/history/bloc/history_state.dart';
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  AuthenticatorRepository authenticatorRepository;
  // Pagination
  int commonPage;
  int succeededSize;
  int failedSize;
  // Timer
  Timer? _getTransactionsListTimer;
  // Lock
  bool _isGettingTransactionsListSubmitting = false;
  bool _isGettingTransactionsListTimerRunning = false;

  HistoryBloc(
      {required this.authenticatorRepository,
      this.commonPage = 1,
      this.succeededSize = kTransactionItemsPagSize,
      this.failedSize = kTransactionItemsPagSize})
      : super(HistoryState()) {
    on<HistoryEventTransactionStatusChanged>((event, emit) {
      emit(state.copyWith(transactionStatus: event.transactionStatus));
    });

    on<HistoryEventGetTransactionsListAndSetupTimer>((event, emit) async {
      if (_isGettingTransactionsListSubmitting) return;
      _isGettingTransactionsListSubmitting = true;
      try {
        final accountData = await UserData.getCredentialAccountData();
        emit(state.copyWith(
            getTransactionListStatus: RequestStatusSubmitting()));
        // Track event detail
        if (event.needMorePage != null) {
          if (state.transactionStatus == TransactionStatus.succeeded) {
            succeededSize += kTransactionItemsPagSize;
          } else {
            failedSize += kTransactionItemsPagSize;
          }
        }
        // Call request
        _getSucceededTransactionsListAsync() async =>
            await authenticatorRepository.getTransactionsList(
                accountData!.bcAddress, TransactionStatus.succeeded,
                currentPage: commonPage, pageSize: succeededSize);
        _getFailedTransactionsListAsync() async =>
            await authenticatorRepository.getTransactionsList(
                accountData!.bcAddress, TransactionStatus.failed,
                currentPage: commonPage, pageSize: failedSize);

        // Get lists
        final List<GetTransactionsListResponseModel>
            getTransactionsListResults = await Future.wait([
          _getSucceededTransactionsListAsync(),
          _getFailedTransactionsListAsync()
        ]);

        final _succeededTransactionList = getTransactionsListResults
            .where((result) =>
                result.transactionStatus == TransactionStatus.succeeded)
            .toList()[0];
        final _failedTransactionList = getTransactionsListResults
            .where((result) =>
                result.transactionStatus == TransactionStatus.failed)
            .toList()[0];

        //  (imp) Categorize the transactions list
        // - Get current and history state (no need)
        // - Categorize
        final _categorizedSucceededTransactionsInfo = categorizeTransactions(
            newTransactionsList: _succeededTransactionList.transactionsList);
        final _categorizedFailedTransactionsInfo = categorizeTransactions(
            newTransactionsList: _failedTransactionList.transactionsList);

        // Update new state
        emit(state.copyWith(
            categorizedSucceededTransactionsInfo:
                _categorizedSucceededTransactionsInfo,
            categorizedFailedTransactionsInfo:
                _categorizedFailedTransactionsInfo,
            getTransactionListStatus: RequestStatusSuccess()));

        // Setup timer
        if (!isClosed) {
          add(HistoryEventSetupGetTransactionsListTimer());
        }
      } on Exception catch (e) {
        emit(state.copyWith(getTransactionListStatus: RequestStatusFailed(e)));
      }
      // Change to initial + reset notifications
      emit(state.copyWith(
          getTransactionListStatus: const RequestStatusInitial()));
      _isGettingTransactionsListSubmitting = false;
    });

    on<HistoryEventSetupGetTransactionsListTimer>((event, emit) async {
      if (_isGettingTransactionsListTimerRunning) return;
      _isGettingTransactionsListTimerRunning = true;
      _getTransactionsListTimer = Timer.periodic(
          const Duration(seconds: socketPeriodSecond), (Timer timer) {
        if (isClosed || !_isGettingTransactionsListTimerRunning) {
          // Cancel timer
          _cancelGetTransactionsListTimer();
        } else {
          if (!isClosed) {
            add(HistoryEventGetTransactionsListAndSetupTimer());
          }
        }
      });
    });
  }

  _cancelGetTransactionsListTimer() {
    _getTransactionsListTimer?.cancel();
    _getTransactionsListTimer = null;
    _isGettingTransactionsListTimerRunning = false;
  }

  refreshTransactionsList({bool? needMorePage}) async {
    _cancelGetTransactionsListTimer();
    if (!isClosed) {
      add(HistoryEventGetTransactionsListAndSetupTimer(
          needMorePage: needMorePage));
      await stream.first; // Submitting
      await stream.first; // Success
    }
  }
}
