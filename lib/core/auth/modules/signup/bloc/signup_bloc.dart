import 'package:botp_auth/common/state/form_submission_status.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_event.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_state.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
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
      emit(state.copyWith(formStatus: FormStatusSubmitting()));
      try {
        final signUpResult = await authRepo.signUp(state.password);
        if (signUpResult.status) {
          UserData.setSessionData(SessionType.authenticated);
          sessionCubit.launchSession();
          emit(state.copyWith(formStatus: FormStatusSuccess()));
        } else {
          throw Exception("Unknown error on sign up");
        }
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormStatusFailed(e)));
      }
    });
  }
}
