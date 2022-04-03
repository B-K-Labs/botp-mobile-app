import 'package:botp_auth/common/state/form_submission_status.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_event.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;

  SignUpBloc({required this.authRepo}) : super(SignUpState()) {
    // On changed
    on<SignUpEventPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignUpEventSubmitted>((event, emit) {
      emit(state.copyWith(formStatus: FormStatusSubmitting()));
      try {
        authRepo.signUp(state.password);
        // Store local storage
        emit(state.copyWith(formStatus: FormStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormStatusFailed(e)));
      }
    });
  }
}
