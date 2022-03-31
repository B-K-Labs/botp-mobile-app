import 'package:botp_auth/common/state/form_submission_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/auth/cubit/auth_cubit.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_bloc.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_event.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_state.dart';
import 'package:botp_auth/core/auth/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpBloc(
            authRepository: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Background(
            child: Stack(children: [_signUpForm(context), _otherOptions()])));
  }

  void _showSnackBar(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _signUpForm(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
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
            const SizedBox(height: 16.0),
            Text("Create new account",
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
      _passwordValidator(value) => state.validatePassword(value);
      _passwordOnChanged(value) => context
          .read<SignUpBloc>()
          .add(SignUpEventPasswordChanged(password: value));
      return PasswordInputFieldWidget(
          validator: _passwordValidator, onChanged: _passwordOnChanged);
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      onSignUp() => context.read<SignUpBloc>().add(SignUpEventSubmitted());
      return state.formStatus is FormStatusSubmitting
          ? const CircularProgressIndicator()
          : NormalButtonWidget(
              text: "Create account",
              press: onSignUp,
              primary: AppColors.whiteColor,
              backgroundColor: AppColors.primaryColor,
            );
    });
  }

  // 2. Other options (would be deprecated soon)
  Widget _otherOptions() {
    return Column(children: [
      const SizedBox(height: 60.0),
      SubButtonWidget(
        text: "Import existing account",
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
