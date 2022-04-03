import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signin_other/bloc/signin_other_event.dart';
import 'package:botp_auth/core/auth/modules/signin_other/bloc/signin_other_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/common/state/form_submission_status.dart';

class SignInOtherBloc extends Bloc<SignInOtherEvent, SignInOtherState> {
  final AuthRepository authRepository;

  SignInOtherBloc({required this.authRepository}) : super(SignInOtherState()) {
    // On changed
    on<SignInOtherPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(privateKey: event.privateKey)));
    on<SignInOtherPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignInOtherSubmitted>((event, emit) async {
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
