import 'package:botp_auth/common/state/form_submission_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signin_other/bloc/signin_other_bloc.dart';
import 'package:botp_auth/core/auth/modules/signin_other/bloc/signin_other_state.dart';
import 'package:botp_auth/core/auth/modules/signin_other/bloc/signin_other_event.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInOtherScreen extends StatelessWidget {
  const SignInOtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.white10,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: AppColors.blackColor,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
        body: const SafeArea(child: SignInOtherBody()));
  }
}

class SignInOtherBody extends StatefulWidget {
  const SignInOtherBody({Key? key}) : super(key: key);

  @override
  _SignInOtherBodyState createState() => _SignInOtherBodyState();
}

class _SignInOtherBodyState extends State<SignInOtherBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SignInOtherBloc(authRepository: context.read<AuthRepository>()),
        child: Background(
            child:
                Stack(children: [_signInOtherForm(context), _otherOptions()])));
  }

  void _showSnackBar(context, message) {
    final snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _signInOtherForm(context) {
    return BlocListener<SignInOtherBloc, SignInOtherState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormStatusFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const SizedBox(height: 36.0),
            Text("Import an existing account",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: AppColors.primaryColor)),
            const SizedBox(height: 72.0),
            Text("Private key", style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 12.0),
            _privateKeyField(),
            const SizedBox(height: 24.0),
            Text("Password", style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 12.0),
            _passwordField(),
            const SizedBox(height: 36.0),
            _signInOtherButton(),
          ],
        )));
  }

  Widget _signInOtherButton() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      onSignIn() => context.read<SignInOtherBloc>().add(SignInOtherSubmitted());
      return state.formStatus is FormStatusSubmitting
          ? const CircularProgressIndicator()
          : NormalButtonWidget(
              text: "Import account",
              press: onSignIn,
              primary: AppColors.whiteColor,
              backgroundColor: AppColors.primaryColor,
            );
    });
  }

  Widget _privateKeyField() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      _privateKeyValidator(value) => state.validatePrivateKey;
      _privateKeyOnChanged(value) => context
          .read<SignInOtherBloc>()
          .add(SignInOtherPrivateKeyChanged(privateKey: value));
      _onNavigateQrCode() => null;
      return NormalInputFieldWidget(
          validator: _privateKeyValidator,
          onChanged: _privateKeyOnChanged,
          suffixIconData: Icons.qr_code,
          onTapSuffixIcon: _onNavigateQrCode);
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      _passwordValidator(value) => state.validatePassword;
      _passwordOnChanged(value) => context
          .read<SignInOtherBloc>()
          .add(SignInOtherPasswordChanged(password: value));
      return PasswordInputFieldWidget(
          validator: _passwordValidator, onChanged: _passwordOnChanged);
    });
  }

  Widget _otherOptions() {
    return Column(
      children: [
        const SizedBox(height: 60.0),
        SubButtonWidget(
          text: "Sign in with current account",
          press: () {
            Application.router.navigateTo(context, "/signin/current");
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
