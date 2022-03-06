import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/modules/signin/bloc/signin_bloc.dart';
import 'package:botp_auth/modules/signin/screens/signin_other_screen.dart';
import 'package:botp_auth/modules/signup/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/modules/signin/repositories/signin_repository.dart';
import 'package:botp_auth/modules/app/screens/app_screen.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInCurrentScreen extends StatelessWidget {
  const SignInCurrentScreen({Key? key}) : super(key: key);

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
          body: SignInCurrentBody()),
    );
  }
}

class SignInCurrentBody extends StatefulWidget {
  const SignInCurrentBody({Key? key}) : super(key: key);

  @override
  _SignInCurrentBodyState createState() => _SignInCurrentBodyState();
}

class _SignInCurrentBodyState extends State<SignInCurrentBody> {
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 24.0),
          AppPasswordInputField(controller: _passwordController),
          const SizedBox(height: 36.0),
          Row(children: <Widget>[
            Expanded(
                child: AppNormalButton(
              text: "Sign in",
              press: () {
                Application.router.navigateTo(context, "/authenticator");
              },
              primary: AppColors.whiteColor,
              backgroundColor: AppColors.primaryColor,
            )),
            const SizedBox(
              width: 12.0,
            ),
            SizedBox(
                width: 48.0,
                height: 48.0,
                child: AppIconButton(
                    iconData: FontAwesomeIcons.fingerprint,
                    color: AppColors.primaryColor,
                    onPressed: () {},
                    size: 24.0)),
          ]),
          const SizedBox(height: 60.0),
          AppSubButton(
            text: "Import existing account",
            press: () {
              Application.router.navigateTo(context, "/signin/other");
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
      )),
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
    // Size size = MediaQuery.of(context).size;
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
