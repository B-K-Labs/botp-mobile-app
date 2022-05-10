import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthenticationRepository authenticationRepository;

  // Mark that user has skipped
  bool didSkipKyc = false;
  bool didSkipBiometric = false;

  SessionCubit({required this.authenticationRepository})
      : super(UnknownSessionState()) {
    initUserSession(); // Get user's session from storage
  }

  reloadSessionState() {
    // Note: Run only after when the widget is built
    if (state is! UnknownSessionState) {
      final oldState = state;
      emit(UnknownSessionState());
      emit(oldState);
    }
  }

  void initUserSession() async {
    // Just run once, after the app is launched
    final sessionData =
        await UserData.getCredentialSessionData(); // Get session data
    if (sessionData == null ||
        sessionData.sessionType == UserDataSession.firstTime) {
      UserData.setCredentialSessionData(UserDataSession.firstTime);
      emit(FirstTimeSessionState());
    } else if (sessionData.sessionType == UserDataSession.unauthenticated) {
      emit(UnauthenticatedSessionState());
    } else {
      emit(ExpiredSessionState());
    }
  }

  void completedWalkThrough() {
    emit(UnauthenticatedSessionState());
  }

  // Authentication process is success
  remindSettingUpAndLaunchSession(
      {bool? skipSetupKyc, bool? skipSetupBiometric}) async {
    // Check saved data
    final profileData = await UserData.getCredentialProfileData();
    final biometricData = await UserData.getCredentialBiometricData();
    final needSetupKyc = !(profileData?.didKyc == true);
    final needSetupBiometric = !(biometricData?.isActivated == true);

    // Mark if user skipped
    if (skipSetupKyc == true) {
      didSkipKyc = true;
    }
    if (skipSetupBiometric == true) {
      didSkipBiometric = true;
    }

    // Reminding
    // 1. setup KYC
    if (!didSkipKyc && needSetupKyc) {
      emit(RemindSetupKYCSessionState());
    }
    // 2. setup fingerprint
    else if (!didSkipBiometric && needSetupBiometric) {
      emit(RemindSetupBiometricSessionState());
    }
    // Reminding finished
    else {
      emit(AuthenticatedSessionState()); // Only in this
    }
  }

  saveSessionFromSignIn(String bcAddress, String publicKey, String privateKey,
      String password, String? avatarUrl, UserKYC? userKyc) async {
    // Not clear other data - just override old data.
    // await UserData.clearData();
    await UserData.setCredentialSessionData(UserDataSession.expired);
    await UserData.setCredentialAccountData(
        bcAddress, publicKey, privateKey, password);
    final didKyc = userKyc != null;
    if (userKyc != null) {
      await UserData.setCredentialKYCData(userKyc.fullName, userKyc.address,
          userKyc.age, userKyc.gender, userKyc.debitor);
    }
    await UserData.setCredentialProfileData(didKyc, avatarUrl);
    // remindSettingUpAndLaunchSession(skipSetupKyc: didKyc);
  }

  saveSessionFromSignUp(String bcAddress, String publicKey, String privateKey,
      String password) async {
    await UserData.clearData();
    await UserData.setCredentialSessionData(UserDataSession.expired);
    await UserData.setCredentialAccountData(
        bcAddress, publicKey, privateKey, password);
    await UserData.setCredentialProfileData(false, null);
    // remindSettingUpAndLaunchSession(skipSetupKyc: false);
  }

  saveSessionFromImport(String bcAddress, String publicKey, String privateKey,
      String newPassword, String? avatarUrl, UserKYC? userKyc) async {
    await UserData.clearData();
    await UserData.setCredentialSessionData(UserDataSession.expired);
    await UserData.setCredentialAccountData(
        bcAddress, publicKey, privateKey, newPassword);
    final didKyc = userKyc != null;
    if (userKyc != null) {
      await UserData.setCredentialKYCData(userKyc.fullName, userKyc.address,
          userKyc.age, userKyc.gender, userKyc.debitor);
    }
    await UserData.setCredentialProfileData(didKyc, avatarUrl);
    // remindSettingUpAndLaunchSession(skipSetupKyc: didKyc);
  }

  Future<void> signOut() async {
    await UserData.setCredentialSessionData(UserDataSession.expired);
    emit(ExpiredSessionState()); // Use the same instance
  }
}
