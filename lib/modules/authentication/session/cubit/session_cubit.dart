import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/modules/authentication/auth_repository.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// (dev only) Use mock data!!!!!!!!!!!!!!!!
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' as s;

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepository;

  SessionCubit({required this.authRepository}) : super(UnknownSessionState()) {
    // Get user's session from storage
    initUserSession();
  }

  void initUserSession() async {
    // * Note: Fresh app
    await UserData.clear();
    // Get session data
    final sessionData = await UserData.getSessionData();
    // 1. Local storage only
    // final yamlFileUrlString =
    //     await s.rootBundle.loadString('lib/common/mock/userdata.yaml');
    // final userData = loadYaml(yamlFileUrlString);
    // print(userData);
    // await UserData.setCredentialAccountData(userData["account"]["bcAddress"],
    //     userData["account"]["publicKey"], userData["account"]["privateKey"]);
    // await UserData.setCredentialProfileData(
    //     userData["profile"]["avatarUrl"],
    //     userData["profile"]["fullName"],
    //     userData["profile"]["age"],
    //     userData["profile"]["gender"],
    //     userData["profile"]["address"],
    //     userData["profile"]["debitor"]);
    // emit(AuthenticatedSessionState());
    // return;
    // First time
    if (sessionData == null ||
        sessionData.sessionType == SessionType.firstTime) {
      // (skip) Walkthrough here
      UserData.setSessionData(SessionType.unauthenticated);
      // emit(FirstTimeSessionState()); // Skip - when walkthrough pages are implemented
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == SessionType.unauthenticated) {
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == SessionType.expired) {
      emit(ExpiredSessionState());
    } else if (sessionData.sessionType == SessionType.authenticated) {
      // (later) Verfiy user session
      emit(ExpiredSessionState());
    }
  }

  // Authentication process is success
  void launchSession() {
    emit(AuthenticatedSessionState());
  }

  Future<void> signOut() async {
    bool result = await authRepository.signOut();
    if (result) {
      emit(UnauthenticatedSessionState());
    }
  }
}
