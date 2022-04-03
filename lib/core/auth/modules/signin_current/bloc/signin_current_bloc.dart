import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_event.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_state.dart';
import 'package:botp_auth/common/state/form_submission_status.dart';

class SignInCurrentBloc extends Bloc<SignInCurrentEvent, SignInCurrentState> {
  final AuthRepository authRepository;

  SignInCurrentBloc({required this.authRepository})
      : super(SignInCurrentState()) {
    // On changed
    on<SignInCurrentPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(privateKey: event.privateKey)));
    on<SignInCurrentPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignInCurrentSubmitted>((event, emit) async {
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
