import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/modules/authentication/init/screens/init_screen.dart';
import 'package:botp_auth/modules/authentication/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/authentication/walkthroughs/screens/walkthrough_screen.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_state.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();
    // Reload state (if needed) on Widget build completed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SessionCubit>().reloadSessionState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(listener: (context, state) {
      if (state is RemindSetupKYCSessionState) {
        Application.router
            .navigateTo(context, "/auth/reminder/kyc", clearStack: true);
      } else if (state is RemindSetupBiometricSessionState) {
        Application.router
            .navigateTo(context, "/auth/reminder/biometric", clearStack: true);
      } else if (state is AuthenticatedSessionState) {
        Application.router.navigateTo(context, "/botp", clearStack: true);
      }
    }, builder: (context, state) {
      if (state is FirstTimeSessionState) {
        return const WalkThroughScreen();
      } else if (state is UnauthenticatedSessionState) {
        return const InitScreen();
      } else if (state is ExpiredSessionState) {
        return SignInScreen(state.autoSignInWithBiometric);
      } else {
        return const Scaffold();
      }
    });
  }
}
