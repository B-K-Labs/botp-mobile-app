import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/widgets/button.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ReminderBiometricSetupScreen extends StatelessWidget {
  const ReminderBiometricSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ReminderBiometricSetupBody()));
  }
}

class ReminderBiometricSetupBody extends StatelessWidget {
  const ReminderBiometricSetupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
            Text("Setup biometric",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 24.0),
            Text(
              "Do you want to use biometric authentication for the next sign-in time?",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 120.0,
              width: 120.0,
              child: Image.asset("assets/images/temp/botp_temp.png",
                  scale: 1, fit: BoxFit.contain),
            )
          ]),
          Column(
            children: [
              Row(children: <Widget>[
                Expanded(
                    child: ButtonNormalWidget(
                  text: "Skip",
                  type: ButtonNormalType.secondaryOutlined,
                  onPressed: () {
                    Application.router.navigateTo(context, "/");
                    context
                        .read<SessionCubit>()
                        .remindSettingUpAndLaunchSession(
                            skipSetupBiometric: true);
                  },
                )),
                const SizedBox(
                  width: kAppPaddingBetweenItemSmallSize,
                ),
                Expanded(
                    child: ButtonNormalWidget(
                        text: "Set up now",
                        type: ButtonNormalType.primary,
                        onPressed: () async {
                          Application.router.navigateTo(
                              context, "/botp/settings/security/setupBiometric",
                              routeSettings: const RouteSettings(
                                  arguments: FromScreen.authReminderKYCSetup));
                        })),
              ]),
              const SizedBox(height: kAppPaddingVerticalSize)
            ],
          )
        ],
      ),
    );
  }
}
