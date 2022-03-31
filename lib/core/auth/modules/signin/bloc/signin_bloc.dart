import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/core/auth/repositories/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signin/bloc/signin_event.dart';
import 'package:botp_auth/core/auth/modules/signin/bloc/signin_state.dart';
import 'package:botp_auth/common/state/form_submission_status.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInState()) {
    // On changed
    on<SignInPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(privateKey: event.privateKey)));
    on<SignInPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignInSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormStatusSubmitting()));
      try {
        await authRepository.signIn(state.privateKey, state.password);
        emit(state.copyWith(formStatus: FormStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormStatusFailed(e)));
      }
    });
  }
}
