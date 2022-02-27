import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/dashboard/screens/dashboard_screen.dart';
import 'package:botp_auth/modules/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/signup/screens/import_account_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
        const Text("Register new BOTP account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        SizedBox(height: size.height * 0.1),
        const PasswordField(hintText: "Password"),
        SizedBox(height: size.height * 0.03),
        AppNormalButton(
          text: "Sign up",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const MainAppScreen();
            }));
          },
          primary: Colors.white,
          backgroundColor: AppColors.primaryColor,
        ),
        SizedBox(height: size.height * 0.03),
        const Text('or'),
        SizedBox(height: size.height * 0.03),
        AppNormalButton(
          text: "Import an existing account",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const ImportAccountScreen();
            }));
          },
          primary: Colors.white,
          backgroundColor: AppColors.primaryColor,
        ),
        AppNormalButton(
          text: "Sign in here",
          press: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const SignInScreen();
            }));
          },
          primary: Colors.black,
          backgroundColor: AppColors.primaryColorLight,
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
