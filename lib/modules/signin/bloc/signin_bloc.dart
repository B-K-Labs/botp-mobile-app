import 'package:botp_auth/modules/signin/bloc/signin_events.dart';
import 'package:botp_auth/modules/signin/bloc/signin_states.dart';
import 'package:botp_auth/modules/signin/models/form_submission_status.dart';
import 'package:botp_auth/modules/signin/repositories/signin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository signInRepository;

  SignInBloc({required this.signInRepository}) : super(SignInState()) {
    on<SignInUsernameChanged>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<SignInPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<SignInSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await signInRepository.signIn();
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
