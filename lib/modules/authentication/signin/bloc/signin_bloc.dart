import 'package:botp_auth/common/states/biometric_auth_status.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/utils/services/local_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_event.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_state.dart';
import 'package:botp_auth/common/states/request_status.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository authRepository;
  final SessionCubit sessionCubit;
  // Text controller
  final passwordController = TextEditingController();
  // Flags
  bool _isSubmitting = false;
  bool _isBiometricAuthenticating = false;

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
        // Extracted password from Biometric auth/User input
        final password = event.password ?? state.password;
        // Update password
        emit(state.copyWith(password: password));
        passwordController.text = password;
        // Sign in
        final signInResult = await authRepository.signIn(privateKey, password);
        // Save session
        await sessionCubit.saveNewSessionFromSignIn(
            signInResult.bcAddress,
            signInResult.publicKey,
            privateKey,
            password,
            signInResult.avatarUrl,
            signInResult.userKyc);
        // Launch session
        await sessionCubit.remindSettingUpAndLaunchSession();
        emit(state.copyWith(formStatus: RequestStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
      emit(state.copyWith(formStatus: const RequestStatusInitial()));
      _isSubmitting = false;
    });

    on<SignInEventBiometricAuth>((event, emit) async {
      if (!event.isEnabled) return;
      if (_isBiometricAuthenticating) return;
      _isBiometricAuthenticating = true;
      emit(
          state.copyWith(biometricAuthStatus: BiometricAuthStatusSubmitting()));
      // Auto biometric sign in
      bool isNotSilent = !event.isSilent;

      try {
        // Check if biometric supported
        final isBiometricHardwareSupported =
            await LocalAuth.isBiometricSupported();
        if (!isBiometricHardwareSupported) {
          throw Exception(
              "Your device does not support biometric authentication.");
        }

        // Check if enabled
        final biometricData = await UserData.getCredentialBiometricData();
        final isBiometricActivated = biometricData?.isActivated ?? false;
        if (!isBiometricActivated) {
          throw Exception(
              "Biometric authentication is not enabled. Please enter password instead.");
        }

        // Authenticating
        final biometricAuthResult = await LocalAuth.authenticateWithBiometric();
        if (biometricAuthResult) {
          // Sign in
          final password =
              (await UserData.getCredentialAccountData())!.password;
          add(SignInEventSubmitted(password: password));
        } else {
          // Not return error
        }
      } on Exception catch (e) {
        if (isNotSilent) {
          emit(state.copyWith(
              biometricAuthStatus: BiometricAuthStatusFailed(e)));
        }
      }
      _isBiometricAuthenticating = false;
      emit(state.copyWith(
          biometricAuthStatus: const BiometricAuthStatusInitial()));
    });
  }
}
