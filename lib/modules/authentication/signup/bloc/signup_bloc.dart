import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/common/repositories/auth_repository.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_event.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final SessionCubit sessionCubit;

  SignUpBloc({required this.authRepo, required this.sessionCubit})
      : super(SignUpState()) {
    // On changed
    on<SignUpEventPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignUpEventSubmitted>((event, emit) async {
      if (state.formStatus is RequestStatusSubmitting) return;
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final signUpResult = await authRepo.signUp(state.password);
        UserData.setSessionData(SessionType.authenticated);
        UserData.setCredentialAccountData(signUpResult.bcAddress,
            signUpResult.publicKey, signUpResult.privateKey);
        sessionCubit.launchSession();
        emit(state.copyWith(formStatus: RequestStatusSuccessful()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
    });
  }
}
