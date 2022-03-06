import 'package:botp_auth/configs/routes/application.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/app/screens/app_screen.dart';
import 'package:botp_auth/modules/signin/screens/signin_current_screen.dart';
import 'package:botp_auth/modules/signup/screens/signup_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';

class SignInOtherScreen extends StatelessWidget {
  const SignInOtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //     automaticallyImplyLeading: true,
        //     backgroundColor: kPrimaryColor,
        //     leading: IconButton(
        //       icon: const Icon(Icons.arrow_back),
        //       onPressed: () => Navigator.pop(context, false),
        //     )),
        body: SignInOtherBody());
  }
}

class SignInOtherBody extends StatefulWidget {
  const SignInOtherBody({Key? key}) : super(key: key);

  @override
  _SignInOtherBodyState createState() => _SignInOtherBodyState();
}

class _SignInOtherBodyState extends State<SignInOtherBody> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 72.0),
        Text("Import an existing account",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: AppColors.primaryColor)),
        const SizedBox(height: 96.0),
        Text("Private key", style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 12.0),
        AppNormalInputField(suffixIconData: Icons.qr_code, onTapSuffix: () {}),
        const SizedBox(height: 24.0),
        Text("Password", style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 12.0),
        AppPasswordInputField(controller: _passwordController),
        const SizedBox(height: 36.0),
        AppNormalButton(
          text: "Import account",
          press: () {
            Application.router.navigateTo(context, "/authenticator");
          },
          primary: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
        ),
        const SizedBox(height: 60.0),
        AppSubButton(
          text: "Sign in with current account",
          press: () {
            Application.router.navigateTo(context, "/signin/current");
          },
          primary: AppColors.primaryColor,
        ),
        const SizedBox(height: 12.0),
        AppSubButton(
          text: "Create new account",
          press: () {
            Application.router.navigateTo(context, "/signup");
          },
          primary: AppColors.primaryColor,
        ),
      ],
    ));
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
