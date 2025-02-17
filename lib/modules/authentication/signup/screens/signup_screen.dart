import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_bloc.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_event.dart';
import 'package:botp_auth/modules/authentication/signup/bloc/signup_state.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(appBarElevation: 0, body: SignUpBody());
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
    return BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(
            authRepo: context.read<AuthenticationRepository>(),
            sessionCubit: context.read<SessionCubit>()),
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalSize),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_signUpForm()])));
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is RequestStatusFailed) {
            showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: kAppPaddingVerticalSize),
                Text("Create account",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 24.0),
                Text('Password', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12.0),
                _passwordField(),
                const SizedBox(height: 24.0),
                _signUpButton(),
              ],
            )));
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      passwordValidator(value) => state.validatePassword;
      passwordOnChanged(value) => context
          .read<SignUpBloc>()
          .add(SignUpEventPasswordChanged(password: value));
      return FieldPasswordWidget(
        textInputAction: TextInputAction.done,
        autofocus: true,
        hintText: "******",
        validator: passwordValidator,
        onChanged: passwordOnChanged,
      );
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
      return ButtonNormalWidget(
        text: "Create account",
        onPressed: onSignUp,
      );
    });
  }
}
