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
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(children: [
              const SizedBox(height: 104.0),
              Text("Experience the novel authenticator.",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Theme.of(context).colorScheme.primary))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 150.0,
                width: 150.0,
                child: Image.asset("assets/images/logo/botp_logo_splash.png",
                    scale: 1, fit: BoxFit.fitWidth),
              )
            ]),
            Column(children: [
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
                  Application.router.navigateTo(context, "/auth/signIn",
                      transition: TransitionType.inFromRight);
                },
                buttonType: ButtonNormalType.primaryGhost,
              ),
              const SizedBox(height: 24.0),
            ])
          ],
        ));
  }
}
