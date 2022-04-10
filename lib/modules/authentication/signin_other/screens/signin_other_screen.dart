import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/authentication/auth_repository.dart';
import 'package:botp_auth/modules/authentication/signin_other/bloc/signin_other_bloc.dart';
import 'package:botp_auth/modules/authentication/signin_other/bloc/signin_other_state.dart';
import 'package:botp_auth/modules/authentication/signin_other/bloc/signin_other_event.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
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
        ),
        body: const SafeArea(
            minimum: EdgeInsets.all(kPaddingSafeArea),
            child: SignInOtherBody()));
  }
}

class SignInOtherBody extends StatefulWidget {
  const SignInOtherBody({Key? key}) : super(key: key);

  @override
  _SignInOtherBodyState createState() => _SignInOtherBodyState();
}

class _SignInOtherBodyState extends State<SignInOtherBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignInOtherBloc(
            authRepository: context.read<AuthRepository>(),
            sessionCubit: context.read<SessionCubit>()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_signInOtherForm(context), _otherOptions()]));
  }

  void _showSnackBar(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _signInOtherForm(context) {
    return BlocListener<SignInOtherBloc, SignInOtherState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is RequestStatusFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
            key: _formKey,
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
                Text("Private key",
                    style: Theme.of(context).textTheme.bodyText1),
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
      _newPasswordValidator(value) => state.validateNewPassword;
      _newPasswordOnChanged(value) => context
          .read<SignInOtherBloc>()
          .add(SignInOtherNewPasswordChanged(newPassword: value));
      return PasswordInputFieldWidget(
          validator: _newPasswordValidator, onChanged: _newPasswordOnChanged);
    });
  }

  Widget _signInOtherButton() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      final onSignInOther = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<SignInOtherBloc>().add(SignInOtherSubmitted());
              }
            };
      return NormalButtonWidget(
        text: "Import account",
        press: onSignInOther,
        primary: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
      );
    });
  }

  Widget _otherOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
