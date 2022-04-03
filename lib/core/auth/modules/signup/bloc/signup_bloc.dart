import 'package:botp_auth/common/state/form_submission_status.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_event.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;

  SignUpBloc({required this.authRepo}) : super(SignUpState()) {
    // On changed
    on<SignUpEventPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignUpEventSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormStatusSubmitting()));
      try {
        final res = await authRepo.signUp(state.password);
        // Store local storage
        if (res.status) {
          // Change session type
          UserData.setSessionData(SessionType.authenticated);
        }
        emit(state.copyWith(formStatus: FormStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormStatusFailed(e)));
      }
    });
  }
}
