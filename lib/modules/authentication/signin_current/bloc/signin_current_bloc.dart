import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/authentication/auth_repository.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/modules/authentication/signin_current/bloc/signin_current_event.dart';
import 'package:botp_auth/modules/authentication/signin_current/bloc/signin_current_state.dart';
import 'package:botp_auth/common/states/request_status.dart';

class SignInCurrentBloc extends Bloc<SignInCurrentEvent, SignInCurrentState> {
  final AuthRepository authRepository;
  final SessionCubit sessionCubit;

  SignInCurrentBloc({required this.authRepository, required this.sessionCubit})
      : super(SignInCurrentState()) {
    // On changed
    on<SignInCurrentPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(bcAddress: event.bcAddress)));
    on<SignInCurrentPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignInCurrentSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final signInCurrentResult =
            await authRepository.signIn(state.bcAddress, state.password);
        if (signInCurrentResult.status) {
          UserData.setSessionData(SessionType.authenticated);
          sessionCubit.launchSession();
          emit(state.copyWith(formStatus: RequestStatusSuccessful()));
        } else {
          throw Exception("Unknown error on sign in");
        }
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
    });
  }
}
