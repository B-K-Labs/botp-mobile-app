import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/session/session_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepository;

  SessionCubit({required this.authRepository}) : super(UnknownSessionState()) {
    // Get user's session from storage
    initUserSession();
  }

  void initUserSession() async {
    final sessionData = await UserData.getSessionData();
    // * Note: Fresh app now
    await UserData.clear();
    // First time
    if (sessionData == null ||
        sessionData.sessionType == SessionType.firstTime) {
      // Walkthrough here
      UserData.setSessionData(SessionType.unauthenticated);
      // emit(FirstTimeSessionState()); // Skip - when walkthrough pages are implemented
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == SessionType.unauthenticated) {
      emit(UnauthenticatedSessionState());
    } else if (sessionData.sessionType == SessionType.expired) {
      emit(ExpiredSessionState());
    } else if (sessionData.sessionType == SessionType.authenticated) {
      emit(AuthenticatedSessionState());
    }
  }

  // When authenticated successfully
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
