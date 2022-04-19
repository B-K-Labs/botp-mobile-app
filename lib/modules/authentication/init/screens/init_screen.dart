import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(bottom: true, child: InitBody()));
  }
}

class InitBody extends StatelessWidget {
  const InitBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 240.0),
        Text("What do you want to do?",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 96.0),
        ButtonNormalWidget(
          text: 'Create new account',
          onPressed: () {
            Application.router.navigateTo(context, "/auth/signUp",
                transition: TransitionType.inFromRight);
          },
        ),
        const SizedBox(height: 24.0),
        ButtonNormalWidget(
          text: 'Import an account',
          onPressed: () {
            Application.router.navigateTo(context, "/auth/import",
                transition: TransitionType.inFromRight);
          },
          buttonType: ButtonNormalType.primaryGhost,
        ),
      ],
    );
  }
}
