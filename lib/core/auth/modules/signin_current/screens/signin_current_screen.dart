import 'package:botp_auth/common/state/form_submission_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_bloc.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_event.dart';
import 'package:botp_auth/core/auth/modules/signin_current/bloc/signin_current_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInCurrentScreen extends StatelessWidget {
  const SignInCurrentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.white10,
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => SignInCurrentBloc(
                authRepository: context.read<AuthRepository>()),
            child: const SignInCurrentBody(),
          ),
        ));
  }
}

class SignInCurrentBody extends StatefulWidget {
  const SignInCurrentBody({Key? key}) : super(key: key);

  @override
  _SignInCurrentBodyState createState() => _SignInCurrentBodyState();
}

class _SignInCurrentBodyState extends State<SignInCurrentBody> {
  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Stack(
      children: [_signInCurrentForm(context), _otherOptions()],
    ));
  }

  void _showSnackBar(context, message) {
    final snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _signInCurrentForm(context) {
    return BlocListener<SignInCurrentBloc, SignInCurrentState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormStatusFailed) {
            {
              _showSnackBar(context, formStatus.exception.toString());
            }
          }
        },
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16.0),
            Text("Welcome back!",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: AppColors.primaryColor)),
            const SizedBox(height: 60.0),
            Text("Enter your password",
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 24.0),
            _passwordField(),
            const SizedBox(height: 36.0),
            Row(children: <Widget>[
              Expanded(child: _signInCurrentButton()),
              const SizedBox(
                width: 12.0,
              ),
              _signInFingerprint(),
            ]),
          ],
        )));
  }

  Widget _passwordField() {
    return BlocBuilder<SignInCurrentBloc, SignInCurrentState>(
        builder: (context, state) {
      _passwordValidator(value) => state.validatePassword;
      _passwordOnChanged(value) => context
          .read<SignInCurrentBloc>()
          .add(SignInCurrentPasswordChanged(password: value));
      return PasswordInputFieldWidget(
          validator: _passwordValidator, onChanged: _passwordOnChanged);
    });
  }

  Widget _signInCurrentButton() {
    return BlocBuilder<SignInCurrentBloc, SignInCurrentState>(
        builder: (context, state) => state.formStatus is FormStatusSubmitting
            ? const CircularProgressIndicator()
            : NormalButtonWidget(
                text: "Sign in",
                press: () {
                  Application.router.navigateTo(context, "/authenticator");
                },
                primary: AppColors.whiteColor,
                backgroundColor: AppColors.primaryColor,
              ));
  }

  Widget _signInFingerprint() {
    return SizedBox(
        width: 48.0,
        height: 48.0,
        child: IconButtonWdiget(
            iconData: FontAwesomeIcons.fingerprint,
            color: AppColors.primaryColor,
            onPressed: () {},
            size: 24.0));
  }

  Widget _otherOptions() {
    return Column(
      children: [
        const SizedBox(height: 60.0),
        SubButtonWidget(
          text: "Import existing account",
          press: () {
            Application.router.navigateTo(context, "/signin/other");
          },
          primary: AppColors.primaryColor,
        ),
        const SizedBox(height: 12.0),
        SubButtonWidget(
          text: "Create new account",
          press: () {
            Application.router.navigateTo(context, "/signup");
          },
          primary: AppColors.primaryColor,
        ),
      ],
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
