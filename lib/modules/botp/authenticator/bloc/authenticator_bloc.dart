import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class AuthenticatorBloc extends Bloc<AuthenticatorEvent, AuthenticatorState> {
  AuthenticatorRepository authenticatorRepository;
  // Pagination
  int commonPage;
  int commonSize;
  // Timer
  Timer? _getTransactionsListTimer;
  // Lock
  bool _isGettingTransactionsListSubmitting = false;
  bool _isGettingTransactionsListTimerRunning = false;
  // For history
  bool isNotFetchedFirstTime;

  AuthenticatorBloc(
      {required this.authenticatorRepository,
      this.commonPage = 1,
      this.commonSize = kTransactionItemsPagSize,
      this.isNotFetchedFirstTime = true})
      : super(AuthenticatorState()) {
    on<AuthenticatorEventTransactionStatusChanged>((event, emit) {
      emit(state.copyWith(transactionStatus: event.transactionStatus));
    });

    // on<AuthenticatorEventPaginationChanged>((event, emit) => emit(
    //     state.copyWith(
    //         paginationInfo: PaginationInfo(
    //             currentPage: event.currentPage,
    //             totalPage: state.paginationInfo!.totalPage))));

    on<AuthenticatorEventRemoveTransactionHistory>((event, emit) async {
      final transactionHistoryData =
          await UserData.getCredentialTransactionsHistoryData();
      if (transactionHistoryData != null) {
        if (event.transactionStatus == TransactionStatus.requesting) {
          List<String> newRequestingTransactionSecretIdsList =
              transactionHistoryData.requestingTransactionSecretIdsList;
          newRequestingTransactionSecretIdsList
              .removeWhere((secretId) => secretId == event.transactionSecretId);
          // Update storage
          await UserData.setCredentialTransactionsHistoryData(
              newRequestingTransactionSecretIdsList,
              transactionHistoryData.waitingTransactionSecretIdsList);
          // Re-categorize the transactions list
          final currentTransactionsList = state
                  .categorizedRequestingTransactionsInfo
                  ?.currentTransactionsList ??
              [];
          final currentTransactionSecretIdsList = currentTransactionsList
              .map((e) => e.otpSessionSecretInfo.secretId)
              .toList();
          final newRequestingCategorizedTransactionsInfo =
              categorizeTransactions(
                  newTransactionsList: currentTransactionsList,
                  currentTransactionSecretIdsList:
                      currentTransactionSecretIdsList,
                  historyTransactionSecretIdsList:
                      newRequestingTransactionSecretIdsList);
          // Update state
          emit(state.copyWith(
              categorizedRequestingTransactionsInfo:
                  newRequestingCategorizedTransactionsInfo));
        } else {
          // Update storage
          List<String> newWaitingTransactionSecretIdsList =
              transactionHistoryData.waitingTransactionSecretIdsList;
          newWaitingTransactionSecretIdsList
              .removeWhere((secretId) => secretId == event.transactionSecretId);
          await UserData.setCredentialTransactionsHistoryData(
              transactionHistoryData.requestingTransactionSecretIdsList,
              newWaitingTransactionSecretIdsList);
          // Re-categorize the transactions list
          final currentTransactionsList = state
                  .categorizedWaitingTransactionsInfo
                  ?.currentTransactionsList ??
              [];
          final currentTransactionSecretIdsList = currentTransactionsList
              .map((e) => e.otpSessionSecretInfo.secretId)
              .toList();
          final newWaitingCategorizedTransactionsInfo = categorizeTransactions(
              newTransactionsList: currentTransactionsList,
              currentTransactionSecretIdsList: currentTransactionSecretIdsList,
              historyTransactionSecretIdsList:
                  newWaitingTransactionSecretIdsList);
          // Update state
          emit(state.copyWith(
              categorizedWaitingTransactionsInfo:
                  newWaitingCategorizedTransactionsInfo));
        }
      }
    });

    on<AuthenticatorEventGetTransactionsListAndSetupTimer>((event, emit) async {
      if (_isGettingTransactionsListSubmitting) return;
      _isGettingTransactionsListSubmitting = true;
      try {
        final accountData = await UserData.getCredentialAccountData();
        emit(state.copyWith(
            getTransactionListStatus: RequestStatusSubmitting()));
        // Track event detail
        if (event.needMorePage != null) {
          commonSize += kTransactionItemsPagSize;
        }
        // Call request
        _getRequestingTransactionsListAsync() async =>
            await authenticatorRepository.getTransactionsList(
                accountData!.bcAddress, TransactionStatus.requesting,
                currentPage: commonPage, pageSize: commonSize);
        _getWaitingTransactionsListAsync() async =>
            await authenticatorRepository.getTransactionsList(
                accountData!.bcAddress, TransactionStatus.waiting,
                currentPage: commonPage, pageSize: commonSize);

        // Get lists
        final List<GetTransactionsListResponseModel>
            getTransactionsListResults = await Future.wait([
          _getRequestingTransactionsListAsync(),
          _getWaitingTransactionsListAsync()
        ]);

        final _requestingTransactionList = getTransactionsListResults
            .where((result) =>
                result.transactionStatus == TransactionStatus.requesting)
            .toList()[0];
        final _waitingTransactionList = getTransactionsListResults
            .where((result) =>
                result.transactionStatus == TransactionStatus.waiting)
            .toList()[0];

        //  (imp) Categorize the transactions list
        final List<String> currentRequestingTransactionSecretIdsList = state
                .categorizedRequestingTransactionsInfo
                ?.currentTransactionSecretIdsList ??
            [];
        final List<String> currentWaitingTransactionSecretIdsList = state
                .categorizedWaitingTransactionsInfo
                ?.currentTransactionSecretIdsList ??
            [];
        // - Get history from storage
        final historyTransactionData =
            (await UserData.getCredentialTransactionsHistoryData()) ??
                CredentialTransactionsHistoryDataModel(
                    requestingTransactionSecretIdsList: [],
                    waitingTransactionSecretIdsList: []);
        final List<String> historyRequestingTransactionSecretIdsList =
            historyTransactionData.requestingTransactionSecretIdsList;
        final List<String> historyWaitingTransactionSecretIdsList =
            historyTransactionData.waitingTransactionSecretIdsList;
        // - Categorize
        final _categorizedRequestingTransactionsInfo = categorizeTransactions(
            newTransactionsList: _requestingTransactionList.transactionsList,
            currentTransactionSecretIdsList:
                currentRequestingTransactionSecretIdsList,
            historyTransactionSecretIdsList:
                historyRequestingTransactionSecretIdsList,
            isNotFetchedFirstTime: isNotFetchedFirstTime);
        final _categorizedWaitingTransactionsInfo = categorizeTransactions(
            newTransactionsList: _waitingTransactionList.transactionsList,
            currentTransactionSecretIdsList:
                currentWaitingTransactionSecretIdsList,
            historyTransactionSecretIdsList:
                historyWaitingTransactionSecretIdsList,
            isNotFetchedFirstTime: isNotFetchedFirstTime);
        // - Update new history
        await UserData.setCredentialTransactionsHistoryData(
            _categorizedRequestingTransactionsInfo
                .historyTransactionSecretIdsList!,
            _categorizedWaitingTransactionsInfo
                .historyTransactionSecretIdsList!);
        // Change the flag: to mark new transaction
        isNotFetchedFirstTime = true;

        // Update new state
        emit(state.copyWith(
            categorizedRequestingTransactionsInfo:
                _categorizedRequestingTransactionsInfo,
            categorizedWaitingTransactionsInfo:
                _categorizedWaitingTransactionsInfo,
            notifiedRequestingTransactionsList:
                _categorizedRequestingTransactionsInfo.notifiedTransactionsList,
            notifiedWaitingTransactionsList:
                _categorizedWaitingTransactionsInfo.notifiedTransactionsList,
            getTransactionListStatus: RequestStatusSuccess()));

        // Setup timer
        if (!isClosed) {
          add(AuthenticatorEventSetupGetTransactionsListTimer());
        }
      } on Exception catch (e) {
        emit(state.copyWith(getTransactionListStatus: RequestStatusFailed(e)));
      }
      // Change to initial + reset notifications
      emit(state.copyWith(
          notifiedRequestingTransactionsList: const [],
          notifiedWaitingTransactionsList: const [],
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
          if (!isClosed) {
            add(AuthenticatorEventGetTransactionsListAndSetupTimer());
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
      add(AuthenticatorEventGetTransactionsListAndSetupTimer(
          needMorePage: needMorePage));
      await stream.first; // Submitting
      await stream.first; // Success
    }
  }
}
