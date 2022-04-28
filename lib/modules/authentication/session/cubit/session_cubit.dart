import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthenticationRepository authenticationRepository;

  SessionCubit({required this.authenticationRepository})
      : super(UnknownSessionState()) {
    // Get user's session from storage
    initUserSession();
  }

  void initUserSession() async {
    // Note: just run only one time
    // Get session data
    final sessionData = await UserData.getCredentialSessionData();
    // First time
    if (sessionData == null) {
      // TODO: WalkThrough here
      UserData.setCredentialSessionData(UserDataSession.unauthenticated);
      // emit(FirstTimeSessionState());
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == UserDataSession.unauthenticated) {
      emit(UnauthenticatedSessionState());
    } else {
      emit(ExpiredSessionState());
    }
  }

  // Authentication process is success
  void remindSettingUpAndLaunchSession({required bool skipSetupKyc}) {
    if (!skipSetupKyc) {
      emit(RemindSetupKYCSessionState());
    }
    // TODO: Fingerprint
    else {
      emit(AuthenticatedSessionState()); // Only in this
    }
  }

  void launchSessionFromSignIn(
      String bcAddress,
      String publicKey,
      String privateKey,
      String password,
      String? avatarUrl,
      UserKYC? userKyc) async {
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
    remindSettingUpAndLaunchSession(skipSetupKyc: didKyc);
  }

  void launchSessionFromSignUp(String bcAddress, String publicKey,
      String privateKey, String password) async {
    await UserData.clearData();
    await UserData.setCredentialSessionData(UserDataSession.expired);
    await UserData.setCredentialAccountData(
        bcAddress, publicKey, privateKey, password);
    await UserData.setCredentialProfileData(false, null);
    remindSettingUpAndLaunchSession(skipSetupKyc: false);
  }

  void launchSessionFromImport(
      String bcAddress,
      String publicKey,
      String privateKey,
      String newPassword,
      String? avatarUrl,
      UserKYC? userKyc) async {
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
    remindSettingUpAndLaunchSession(skipSetupKyc: didKyc);
  }

  Future<void> signOut() async {
    await UserData.setCredentialSessionData(UserDataSession.expired);
    emit(ExpiredSessionState()); // Use the same instance
  }
}
