import 'package:botp_auth/modules/signin/bloc/signin_bloc.dart';
import 'package:botp_auth/modules/signup/screens/register_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/signin/repositories/signin_repository.dart';
import 'package:botp_auth/modules/dashboard/screens/dashboard_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          SignInBloc(signInRepository: context.read<SignInRepository>()),
      child: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 72.0),
          Text("Welcome back!",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: AppColors.primaryColor)),
          const SizedBox(height: 96.0),
          Text("Enter your password",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppColors.grayColor04)),
          const SizedBox(height: 24.0),
          const PasswordField(hintText: 'Password'),
          const SizedBox(height: 36.0),
          ButtonNoBorder(
            text: "Sign in",
            press: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const MainAppScreen();
                },
              ));
            },
            primary: Colors.white,
            backgroundColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 60.0),
          SubButton(
            text: "Sign up",
            press: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ));
            },
            primary: AppColors.primaryColor,
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
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kMarginCommon),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ));
  }
}
