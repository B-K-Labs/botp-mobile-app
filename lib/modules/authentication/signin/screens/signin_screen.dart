import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/common/states/biometric_auth_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_bloc.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_event.dart';
import 'package:botp_auth/modules/authentication/signin/bloc/signin_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  final bool autoSignInWithBiometric;
  const SignInScreen(this.autoSignInWithBiometric, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        hasAppBar: false, body: SignInBody(autoSignInWithBiometric));
  }
}

class SignInBody extends StatefulWidget {
  final bool autoSignInWithBiometric;
  const SignInBody(this.autoSignInWithBiometric, {Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(
            authRepository: context.read<AuthenticationRepository>(),
            sessionCubit: context.read<SessionCubit>())
          ..add(SignInEventBiometricAuth(
              isSilent: true, isEnabled: widget.autoSignInWithBiometric)),
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_signInCurrentForm(), _otherOptions()],
            )));
  }

  Widget _signInCurrentForm() {
    return BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          final biometricAuthStatus = state.biometricAuthStatus;
          if (formStatus is RequestStatusFailed) {
            showSnackBar(context, formStatus.exception.toString());
          }
          if (biometricAuthStatus is BiometricAuthStatusFailed) {
            showSnackBar(context, biometricAuthStatus.exception.toString());
          }
        },
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
                Text("Welcome back!",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 24.0),
                const Text("Enter your password"),
                const SizedBox(height: 12.0),
                _passwordField(),
                const SizedBox(height: 24.0),
                Row(children: <Widget>[
                  Expanded(child: _signInCurrentButton()),
                  const SizedBox(
                    width: kAppPaddingBetweenItemSmallSize,
                  ),
                  _signInFingerprint(),
                ]),
              ],
            )));
  }

  Widget _passwordField() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      passwordValidator(value) => state.validatePassword;
      passwordOnChanged(value) => context
          .read<SignInBloc>()
          .add(SignInEventPasswordChanged(password: value));
      return FieldPasswordWidget(
          textInputAction: TextInputAction.done,
          autofocus: true,
          hintText: "******",
          controller: context.read<SignInBloc>().passwordController,
          validator: passwordValidator,
          onChanged: passwordOnChanged);
    });
  }

  Widget _signInCurrentButton() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      final onSignInCurrent = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<SignInBloc>().add(SignInEventSubmitted());
              }
            };
      return ButtonNormalWidget(
        text: "Sign in",
        onPressed: onSignInCurrent,
      );
    });
  }

  Widget _signInFingerprint() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return ButtonIconWidget(
          iconData: Icons.fingerprint,
          onTap: () {
            context.read<SignInBloc>().add(SignInEventBiometricAuth());
          },
          type: ButtonIconType.primaryOutlined,
          size: ButtonIconSize.big,
          shape: ButtonIconShape.normal);
    });
  }

  Widget _otherOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60.0),
        ButtonTextWidget(
          text: "Import existing account",
          onPressed: () {
            Application.router.navigateTo(context, "/auth/import");
          },
        ),
        const SizedBox(height: 12.0),
        ButtonTextWidget(
          text: "Create new account",
          onPressed: () {
            Application.router.navigateTo(context, "/auth/signUp");
          },
        ),
      ],
    );
  }
}
