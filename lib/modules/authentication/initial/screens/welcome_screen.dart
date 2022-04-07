import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.all(kPaddingSafeArea), child: WelcomeBody()));
  }
}

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 240.0),
        Text("What do you want to do?",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: AppColors.primaryColor)),
        const SizedBox(height: 96.0),
        NormalButtonWidget(
            text: 'Import an account',
            press: () {
              Application.router.navigateTo(context, "/signin/other",
                  transition: TransitionType.inFromRight);
            },
            primary: AppColors.whiteColor,
            backgroundColor: AppColors.primaryColor),
        const SizedBox(height: 24.0),
        NormalButtonWidget(
          text: 'Create new account',
          press: () {
            Application.router.navigateTo(context, "/signup",
                transition: TransitionType.inFromRight);
          },
          primary: AppColors.primaryColor,
          backgroundColor: AppColors.whiteColor,
          borderColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
