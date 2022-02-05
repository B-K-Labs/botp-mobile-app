import 'package:botp_auth/modules/signin/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/signin/repositories/signin_repository.dart';
import 'package:botp_auth/modules/dashboard/screens/dashboard_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SignInRepository(),
      child: const Scaffold(
          // appBar: AppBar(
          //     automaticallyImplyLeading: true,
          //     backgroundColor: kPrimaryColor,
          //     leading: IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () => Navigator.pop(context, false),
          //     )),
          body: SignInBody()),
    );
  }
}

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          SignInBloc(signInRepository: context.read<SignInRepository>()),
      child: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Welcome back to BOTP!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
          SizedBox(height: size.height * 0.1),
          const Text("Enter your password",
              style: TextStyle(fontWeight: FontWeight.normal)),
          SizedBox(height: size.height * 0.03),
          const RoundedPasswordField(hintText: 'Password'),
          SizedBox(height: size.height * 0.03),
          const Text('or'),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            text: "Sign in",
            press: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const MainAppScreen();
                },
              ));
            },
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
          ),
        ],
      )),
    ));
  }

  // Widget _passwordField() {
  // return BlocBuilder(builder: (context, state) {
  //   return TextFormField(
  //       decoration: const InputDecoration(
  //         icon: Icon(Icons.password),
  //         hintText: "Password",
  //       ),
  //       validator: (value) => null,
  //       onChanged: (value) => context
  //           .read<SignInBloc>()
  //           .add(SignInPasswordChanged(password: value)));
  // });
  // }

  // Widget _signInButton() {
  //   return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
  //     return state.formStatus is FormSubmitting
  //         ? const CircularProgressIndicator()
  //         : RoundedButton(
  //             text: "Sign up here",
  //             press: () {
  //               Navigator.pushReplacement(context, MaterialPageRoute(
  //                 builder: (context) {
  //                   return const SignUpScreen();
  //                 },
  //               ));
  //             },
  //             primary: Colors.black,
  //             backgroundColor: kPrimaryLightColor,
  //           );
  //   });
  // }
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
