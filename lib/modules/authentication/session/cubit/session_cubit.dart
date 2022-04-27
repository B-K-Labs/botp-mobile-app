import 'package:botp_auth/configs/routes/application.dart';
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
    } else if (sessionData.sessionType == UserDataSession.expired) {
      emit(ExpiredSessionState());
    } else if (sessionData.sessionType == UserDataSession.authenticated) {
      // TODO: Verify user session
      emit(AuthenticatedSessionState());
    }
  }

  // Authentication process is success
  void launchSession({required bool skipSetupKyc}) {
    if (!skipSetupKyc) {
      emit(RemindSetupKYCSessionState());
    } else {
      emit(AuthenticatedSessionState());
    }
  }

  Future<void> signOut() async {
    await UserData.setCredentialSessionData(UserDataSession.expired);
    // emit(ExpiredSessionState()); // Can't: SessionScreen is wiped after a clear stack. Navigate to the Session Screen instead
  }
}
