import 'package:botp_auth/core/auth/repositories/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signin/bloc/signin_event.dart';
import 'package:botp_auth/core/auth/modules/signin/bloc/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/common/statuses/form_submission_status.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInState()) {
    on<SignInUsernameChanged>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<SignInPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<SignInSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        // await signInRepository.signIn();
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
