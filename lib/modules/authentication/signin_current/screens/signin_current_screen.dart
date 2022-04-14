import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/signin_current/bloc/signin_current_bloc.dart';
import 'package:botp_auth/modules/authentication/signin_current/bloc/signin_current_event.dart';
import 'package:botp_auth/modules/authentication/signin_current/bloc/signin_current_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
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
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: const SafeArea(
        minimum: EdgeInsets.all(kPaddingSafeArea),
        child: SignInCurrentBody(),
      ),
    );
  }
}

class SignInCurrentBody extends StatefulWidget {
  const SignInCurrentBody({Key? key}) : super(key: key);

  @override
  _SignInCurrentBodyState createState() => _SignInCurrentBodyState();
}

class _SignInCurrentBodyState extends State<SignInCurrentBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCurrentBloc>(
        create: (context) => SignInCurrentBloc(
            authRepository: context.read<AuthRepository>(),
            sessionCubit: context.read<SessionCubit>()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_signInCurrentForm(context), _otherOptions()],
        ));
  }

  Widget _signInCurrentForm(context) {
    return BlocListener<SignInCurrentBloc, SignInCurrentState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is RequestStatusFailed) {
            {
              showSnackBar(context, formStatus.exception.toString());
            }
          }
        },
        child: Form(
            key: _formKey,
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
        builder: (context, state) {
      final onSignInCurrent = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<SignInCurrentBloc>().add(SignInCurrentSubmitted());
              }
            };
      return NormalButtonWidget(
        text: "Sign in",
        press: onSignInCurrent,
        primary: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
      );
    });
  }

  Widget _signInFingerprint() {
    return SizedBox(
        width: 48.0,
        height: 48.0,
        child: IconButtonWidget(
            iconData: FontAwesomeIcons.fingerprint,
            color: AppColors.primaryColor,
            onPressed: () {},
            size: 24.0));
  }

  Widget _otherOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
