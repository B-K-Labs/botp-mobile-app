import 'package:botp_auth/common/state/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/authentication/auth_repository.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_bloc.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_event.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_state.dart';
import 'package:botp_auth/core/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: const SafeArea(
        child: SignUpBody(),
      ),
    );
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpBloc(
            authRepo: context.read<AuthRepository>(),
            sessionCubit: context.read<SessionCubit>()),
        child: Background(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_signUpForm(context), _otherOptions()])));
  }

  void _showSnackBar(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _signUpForm(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
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
                const SizedBox(height: 16.0),
                Text("Create new security",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: AppColors.primaryColor)),
                const SizedBox(height: 60.0),
                Text('Password', style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 12.0),
                _passwordField(),
                const SizedBox(height: 36.0),
                _signUpButton(),
              ],
            )));
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      _passwordValidator(value) => state.validatePassword;
      _passwordOnChanged(value) => context
          .read<SignUpBloc>()
          .add(SignUpEventPasswordChanged(password: value));
      return PasswordInputFieldWidget(
          validator: _passwordValidator, onChanged: _passwordOnChanged);
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      final onSignUp = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<SignUpBloc>().add(SignUpEventSubmitted());
              }
            };
      return NormalButtonWidget(
        text: "Create security",
        press: onSignUp,
        primary: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
      );
    });
  }

  // 2. Other options (would be deprecated soon)
  Widget _otherOptions() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60.0),
          SubButtonWidget(
            text: "Import existing security",
            press: () {
              Application.router.navigateTo(context, '/signin/other');
            },
            primary: AppColors.primaryColor,
          ),
        ]);
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
