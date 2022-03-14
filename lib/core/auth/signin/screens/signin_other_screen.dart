import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/core/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';

class SignInOtherScreen extends StatelessWidget {
  const SignInOtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignInOtherBody());
  }
}

class SignInOtherBody extends StatefulWidget {
  const SignInOtherBody({Key? key}) : super(key: key);

  @override
  _SignInOtherBodyState createState() => _SignInOtherBodyState();
}

class _SignInOtherBodyState extends State<SignInOtherBody> {
  final TextEditingController _privateKeyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  bool _isLoading = false;

  onSbumitSignIn() {
    if (_isLoading) {
      return;
    }
    if (_privateKeyController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Please enter private key")));
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
    AuthRepository()
        .signIn(_privateKeyController.text, _passwordController.text)
        .then((data) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Import account successfully!")));
      print("Import account successfully!\n\tStatue: ${data.status}");
      Application.router.navigateTo(
        context,
        "/authenticator",
      );
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
        const SizedBox(height: 72.0),
        Text("Import an existing account",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: AppColors.primaryColor)),
        const SizedBox(height: 96.0),
        Text("Private key", style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 12.0),
        NormalInputFieldWidget(
            controller: _privateKeyController,
            suffixIconData: Icons.qr_code,
            onTapSuffix: () {}),
        const SizedBox(height: 24.0),
        Text("Password", style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 12.0),
        PasswordInputFieldWidget(controller: _passwordController),
        const SizedBox(height: 36.0),
        NormalButtonWidget(
          text: "Import account",
          press: onSbumitSignIn,
          primary: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
        ),
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
