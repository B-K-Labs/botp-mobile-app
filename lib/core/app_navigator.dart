import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import "package:flutter/material.dart";

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () async {
    //   final sessionData = await UserData.getSessionData();
    //   // * Note: Fresh app now
    //   await UserData.clear();
    //   // First time
    //   if (sessionData == null ||
    //       sessionData.sessionType == SessionType.firstTime) {
    //     // Walkthrough here
    //     UserData.setSessionData(SessionType.unauthenticated);
    //     Application.router.navigateTo(context, "/signup", replace: true);
    //   } else if (sessionData.sessionType == SessionType.unauthenticated) {
    //     Application.router.navigateTo(context, "/signup", replace: true);
    //   } else if (sessionData.sessionType == SessionType.expired) {
    //     Application.router
    //         .navigateTo(context, "/signin/current", replace: true);
    //   } else if (sessionData.sessionType == SessionType.authenticated) {
    //     Application.router.navigateTo(context, "/authenticator", replace: true);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(); // Waiting for session checking
  }
}
