import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/signin/screens/signin_other_screen.dart';
import 'package:botp_auth/modules/signup/screens/signup_screen.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: WelcomeBody());
  }
}

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // const SizedBox(height: 28.0),
          const SizedBox(height: 240.0),
          Text("What do you want to do?",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: AppColors.primaryColor)),
          const SizedBox(height: 96.0),
          AppNormalButton(
              text: 'Import an account',
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const SignInOtherScreen();
                }));
              },
              primary: AppColors.whiteColor,
              backgroundColor: AppColors.primaryColor),
          const SizedBox(height: 24.0),
          AppNormalButton(
            text: 'Create new account',
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const SignUpScreen();
              }));
            },
            primary: AppColors.primaryColor,
            backgroundColor: AppColors.whiteColor,
            borderColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ));
  }
}
