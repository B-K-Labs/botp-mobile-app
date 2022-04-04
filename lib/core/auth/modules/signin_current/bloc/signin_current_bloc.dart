import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_event.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_state.dart';
import 'package:botp_auth/common/state/form_submission_status.dart';

class SignInCurrentBloc extends Bloc<SignInCurrentEvent, SignInCurrentState> {
  final AuthRepository authRepository;
  final SessionCubit sessionCubit;

  SignInCurrentBloc({required this.authRepository, required this.sessionCubit})
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
        final signInCurrentResult =
            await authRepository.signIn(state.privateKey, state.password);
        if (signInCurrentResult.status) {
          UserData.setSessionData(SessionType.authenticated);
          sessionCubit.launchSession();
          emit(state.copyWith(formStatus: FormStatusSuccess()));
        } else {
          throw Exception("Unknown error on sign in");
        }
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormStatusFailed(e)));
      }
    });
  }
}
