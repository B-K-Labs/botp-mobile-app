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
    // * Note: Fresh app
    await UserData.clear();
    // Get session data
    final sessionData = await UserData.getCredentialSessionData();
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
        sessionData.sessionType == UserDataSession.firstTime) {
      // TODO: Walkthrough here
      UserData.setCredentialSessionData(UserDataSession.unauthenticated);
      // emit(FirstTimeSessionState());
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == UserDataSession.unauthenticated) {
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == UserDataSession.expired) {
      emit(ExpiredSessionState());
    } else if (sessionData.sessionType == UserDataSession.authenticated) {
      // TODO: Verify user session
      emit(AuthenticatedSessionState());
    }
  }

  // Authentication process is success
  void launchSession() {
    emit(AuthenticatedSessionState());
  }

  Future<void> signOut() async {
    bool result = await authenticationRepository.signOut();
    if (result) {
      emit(UnauthenticatedSessionState());
    }
  }
}
