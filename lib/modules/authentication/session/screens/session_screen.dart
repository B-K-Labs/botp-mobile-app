import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/modules/authentication/init/screens/init_screen.dart';
import 'package:botp_auth/modules/authentication/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/authentication/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/authentication/walkthroughs/screens/walkthrough_screen.dart';
import 'package:fluro/fluro.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_state.dart';

// Main navigation
class SessionScreen extends StatelessWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SessionBody();
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
        // BOTP Home
        Application.router.navigateTo(context, "/authenticator",
            transition: TransitionType.inFromRight);
      }
    }, builder: (context, state) {
      if (state is FirstTimeSessionState) {
        return const WalkThroughScreen();
      } else if (state is UnauthenticatedSessionState) {
        return const InitScreen();
      } else if (state is ExpiredSessionState) {
        return const SignInScreen();
      } else {
        return const Scaffold();
      }
    });
  }
}
