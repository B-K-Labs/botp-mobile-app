import 'package:botp_auth/common/statuses/form_submission_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_bloc.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_state.dart';
import 'package:botp_auth/core/auth/repositories/auth_repository.dart';
import 'package:fluro/fluro.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;

  bool _isLoading = false;

  // On submit
  onSubmitSignUp() async {
    if (_isLoading) {
      return;
    }
    if (_passwordController.text.isEmpty) {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Please enter password")));
      return;
    }
    setState(() {
      _isLoading = true;
    });
    AuthRepository().signUp(_passwordController.text).then((data) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Create account successfully!")));
      // print(
      //     "Create account successfully!\n\tAccount BC: ${data.bcAddress}\n\tPublic key: ${data.publicKey}\n\tPrivate key: ${data.privateKey}\n\tEncrypted private key: ${data.encryptedPrivateKey}\n\tStatus: ${data.status}");
      // Application.router.navigateTo(context, "/authenticator",
      //     transition: TransitionType.inFromRight);
    }).catchError((e) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }).whenComplete(() => {
          setState(() {
            _isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Background(
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
        
        const SizedBox(height: 36.0),
        NormalButtonWidget(
          text: "Create account",
          press: onSubmitSignUp,
          primary: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
        ),
        const SizedBox(height: 60.0),
        SubButtonWidget(
          text: "Import existing account",
          press: () {
            Application.router.navigateTo(context, '/signin/other');
          },
          primary: AppColors.primaryColor,
        ),
      ],
    ));
  }
}

// Split into smaller widgets
Widget _passwordField() {
  
}

Widget _signUpButton() {
  return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
    return state.formStatus is FormSubmitting ? CircularProgressIndicator() : PasswordInputFieldWidget()
  })
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
