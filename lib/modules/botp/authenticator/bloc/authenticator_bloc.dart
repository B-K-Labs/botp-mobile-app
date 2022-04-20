import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatorBloc extends Bloc<AuthenticatorEvent, AuthenticatorState> {
  AuthenticatorRepository authenticatorRepository;
  // Pagination
  int page;
  int size;

  AuthenticatorBloc(
      {required this.authenticatorRepository,
      this.page = 1,
      this.size = kTransactionItemsPagSize})
      : super(AuthenticatorState()) {}
}
