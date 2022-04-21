import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/widgets/button.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ReminderKYCSetupScreen extends StatelessWidget {
  const ReminderKYCSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(bottom: true, child: ReminderKYCSetupBody()));
  }
}

class ReminderKYCSetupBody extends StatelessWidget {
  const ReminderKYCSetupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kAppPaddingHorizontalAndBottomSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
            Text("Setup KYC",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 48.0),
            Text(
              "To able to use the authenticator, you have to setup your KYC information",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: Image.asset("assets/images/temp/botp_temp.png",
                  scale: 1, fit: BoxFit.fitWidth),
            )
          ]),
          Column(
            children: [
              Row(children: <Widget>[
                Expanded(
                    child: ButtonNormalWidget(
                  text: "Skip",
                  buttonType: ButtonNormalType.secondaryOutlined,
                  onPressed: () {
                    Application.router.navigateTo(context, "/botp");
                    context
                        .read<SessionCubit>()
                        .launchSession(skipSetupKyc: true);
                  },
                )),
                const SizedBox(
                  width: kAppPaddingBetweenItemSize,
                ),
                Expanded(
                    child: ButtonNormalWidget(
                        text: "Set up now",
                        buttonType: ButtonNormalType.primary,
                        onPressed: () async {
                          final setupKycResult = await Application.router
                              .navigateTo(context,
                                  "/botp/settings/account/setupKyc/${FromScreen.authReminderKYCSetup}");
                          context
                              .read<SessionCubit>()
                              .launchSession(skipSetupKyc: true);
                        })),
              ]),
              const SizedBox(height: kAppPaddingHorizontalAndBottomSize)
            ],
          )
        ],
      ),
    );
  }
}
