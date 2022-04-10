import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/authentication/auth_repository.dart';
import 'package:botp_auth/modules/authentication/signin_other/bloc/signin_other_event.dart';
import 'package:botp_auth/modules/authentication/signin_other/bloc/signin_other_state.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/common/states/request_status.dart';

class SignInOtherBloc extends Bloc<SignInOtherEvent, SignInOtherState> {
  final AuthRepository authRepository;
  final SessionCubit sessionCubit;

  SignInOtherBloc({required this.authRepository, required this.sessionCubit})
      : super(SignInOtherState()) {
    // On changed
    on<SignInOtherPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(privateKey: event.privateKey)));
    on<SignInOtherNewPasswordChanged>(
        (event, emit) => emit(state.copyWith(newPassword: event.newPassword)));

    // On submitted
    on<SignInOtherSubmitted>((event, emit) async {
      if (state.formStatus is RequestStatusSubmitting) return;
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final importResult =
            await authRepository.import(state.privateKey, state.newPassword);
        UserData.setSessionData(SessionType.authenticated);
        sessionCubit.launchSession();
        emit(state.copyWith(formStatus: RequestStatusSuccessful()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
    });
  }
}
