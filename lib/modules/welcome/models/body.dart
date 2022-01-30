import 'package:botp_auth/modules/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/signup/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/welcome/models/background.dart';
import 'package:botp_auth/widgets/button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Welcome to BOTP!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        SizedBox(height: size.height * 0.1),
        RoundedButton(
          text: "Sign in",
          press: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const SignInScreen();
              },
            ));
          },
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        // SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: "Sign up",
          press: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const SignUpScreen();
              },
            ));
          },
          primary: Colors.black,
          backgroundColor: kPrimaryLightColor,
        ),
      ],
    ));
  }
}
