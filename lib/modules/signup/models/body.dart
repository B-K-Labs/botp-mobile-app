import 'package:botp_auth/modules/dashboard/screens/dashboard_screen.dart';
import 'package:botp_auth/modules/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/signup/models/background.dart';
import 'package:botp_auth/modules/signup/screens/import_account_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
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
        const Text("Register new BOTP account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        SizedBox(height: size.height * 0.1),
        const RoundedPasswordField(hintText: "Password"),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: "Sign up",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return const DashboardScreen();
                }));
          },
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        SizedBox(height: size.height * 0.03),
        const Text('or'),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: "Import an existing account",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const ImportAccountScreen();
            }));
          },
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        RoundedButton(
          text: "Sign in here",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const SignInScreen();
            }));
          },
          primary: Colors.black,
          backgroundColor: kPrimaryLightColor,
        ),
      ],
    ));
  }
}
