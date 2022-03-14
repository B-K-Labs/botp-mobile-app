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
    if (sessionData.sessionType == 0) {
      UserData.setSessionData(sessionType: 1);
      // Walkthrough here
    } else if (sessionData.sessionType == 1) {}
    emit(UnauthenticatedSessionState());
  }

  void showAuth() {
    print("Your acccount is all here :love:");
    emit(AuthenticatedSessionState());
  }

  Future<void> signOut() async {
    print("Sign out!!!! heheheheh");
    bool result = await authRepository.signOut();
    if (result) {
      emit(UnauthenticatedSessionState());
    }
  }
}
