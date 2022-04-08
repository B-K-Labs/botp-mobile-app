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
    on<SignInOtherPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignInOtherSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final signInOtherResult =
            await authRepository.signIn(state.privateKey, state.password);
        if (signInOtherResult.status) {
          UserData.setSessionData(SessionType.authenticated);
          sessionCubit.launchSession();
          emit(state.copyWith(formStatus: RequestStatusSuccess()));
        } else {
          throw Exception("Unknown error on sign in");
        }
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
    });
  }
}
