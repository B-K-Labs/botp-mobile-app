import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/dashboard/screens/dashboard_screen.dart';
import 'package:botp_auth/modules/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/signup/screens/register_account_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';

class ImportAccountScreen extends StatelessWidget {
  const ImportAccountScreen({Key? key}) : super(key: key);

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
        body: const Body());
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
        const Text("Import existing BOTP account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        SizedBox(height: size.height * 0.1),
        const RoundedInputField(hintText: "Your private key"),
        const RoundedPasswordField(hintText: "Password"),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: "Sign up",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const MainAppScreen();
            }));
          },
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        SizedBox(height: size.height * 0.03),
        const Text('or'),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: "Register new BOTP account",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const SignUpScreen();
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
