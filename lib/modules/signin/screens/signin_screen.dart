import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/dashboard/screens/dashboard_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/modules/signup/screens/signup_screen.dart';
import 'package:botp_auth/widgets/button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Body());
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Welcome back to BOTP!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        SizedBox(height: size.height * 0.1),
        const Text("Enter your password",
            style: TextStyle(fontWeight: FontWeight.normal)),
        SizedBox(height: size.height * 0.03),
        const RoundedPasswordField(hintText: "Password"),
        RoundedButton(
          text: "Login",
          press: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const DashboardScreen();
              },
            ));
          },
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        SizedBox(height: size.height * 0.03),
        const Text('or'),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: "Sign up here",
          press: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
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

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ));
  }
}
