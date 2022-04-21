import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatorBloc extends Bloc<AuthenticatorEvent, AuthenticatorState> {
  AuthenticatorRepository authenticatorRepository;
  // Pagination
  int page;
  int size;
  // Lock
  bool _isGettingTransactionsList = false;

  AuthenticatorBloc(
      {required this.authenticatorRepository,
      this.page = 1,
      this.size = kTransactionItemsPagSize})
      : super(AuthenticatorState()) {
    on<AuthenticatorEventTransacionStatusChanged>((event, emit) =>
        emit(state.copyWith(transactionStatus: event.transactionStatus)));
    on<AuthenticatorEventPaginationChanged>((event, emit) => emit(
        state.copyWith(
            paginationInfo: PaginationInfo(
                currentPage: event.currentPage,
                totalPage: state.paginationInfo!.totalPage))));
    on<AuthenticatorEventGetTransactionsList>((event, emit) async {
      if (_isGettingTransactionsList) return;
      _isGettingTransactionsList = true;
      print("Hello");
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
      } on Exception catch (e) {
        emit(state.copyWith(getTransactionListStatus: RequestStatusFailed(e)));
      }
      _isGettingTransactionsList = false;
    });
  }
}
