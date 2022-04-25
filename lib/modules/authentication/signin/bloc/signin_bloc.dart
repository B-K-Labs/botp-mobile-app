import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_event.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_state.dart';
import 'package:botp_auth/common/states/request_status.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository authRepository;
  final SessionCubit sessionCubit;
  bool _isSubmitting = false;

  SignInBloc({required this.authRepository, required this.sessionCubit})
      : super(SignInState()) {
    // On changed
    on<SignInEventPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    // On submitted
    on<SignInEventSubmitted>((event, emit) async {
      if (_isSubmitting) return;
      _isSubmitting = true;
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final privateKey =
            (await UserData.getCredentialAccountData())!.privateKey;
        final signInResult =
            await authRepository.signIn(privateKey, state.password);
        // Store account data
        UserData.setCredentialSessionData(UserDataSession.authenticated);
        UserData.setCredentialAccountData(signInResult.bcAddress,
            signInResult.publicKey, privateKey, state.password);
        final userKyc = signInResult.userKyc;
        final didKyc = userKyc != null;
        if (userKyc != null) {
          UserData.setCredentialKYCData(userKyc.fullName, userKyc.address,
              userKyc.age, userKyc.gender, userKyc.debitor);
        }
        UserData.setCredentialProfileData(didKyc, signInResult.avatarUrl);
        sessionCubit.launchSession(skipSetupKyc: didKyc);
        emit(state.copyWith(formStatus: RequestStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
      emit(state.copyWith(formStatus: const RequestStatusInitial()));
      _isSubmitting = false;
    });
  }
}
