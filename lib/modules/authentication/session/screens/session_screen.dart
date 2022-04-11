import 'package:botp_auth/core/modules/authentication/auth_repository.dart';
import 'package:botp_auth/modules/authentication/signin_current/screens/signin_current_screen.dart';
import 'package:botp_auth/modules/authentication/welcome/screens/welcome_screen.dart';
import 'package:botp_auth/modules/botp/authenticator/home/screens/botp_home.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_state.dart';

// Main navigation
class SessionScreen extends StatelessWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>(
        create: (context) =>
            SessionCubit(authRepository: context.read<AuthRepository>()),
        child: const SessionBody());
  }
}

class SessionBody extends StatefulWidget {
  const SessionBody({Key? key}) : super(key: key);

  @override
  State<SessionBody> createState() => _SessionBodyState();
}

class _SessionBodyState extends State<SessionBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(listener: (context, state) {
      if (state is AuthenticatedSessionState) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BOTPHomeScreen()),
            (route) => false);
      }
    }, builder: (context, state) {
      return Navigator(
        pages: [
          if (state is FirstTimeSessionState)
            // TODO: Walkthrough
            const MaterialPage(child: WelcomeScreen()),
          if (state is UnauthenticatedSessionState)
            const MaterialPage(child: WelcomeScreen()),
          if (state is ExpiredSessionState)
            const MaterialPage(child: SignInCurrentScreen()),
          if (state is UnknownSessionState)
            const MaterialPage(
                child: Scaffold(
                    // TODO: Blank scaffold only
                    body: Center(child: CircularProgressIndicator())))
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
