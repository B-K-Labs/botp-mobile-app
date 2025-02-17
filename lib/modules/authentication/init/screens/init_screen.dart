import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(hasAppBar: false, body: InitBody());
  }
}

class InitBody extends StatelessWidget {
  const InitBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(children: [
              const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
              Text("Experience the novel authenticator.",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: Image.asset("assets/images/temp/botp_temp.png",
                    scale: 1, fit: BoxFit.contain),
              )
            ]),
            Column(children: [
              ButtonNormalWidget(
                text: 'Create new account',
                onPressed: () {
                  Application.router.navigateTo(context, "/auth/signUp");
                },
              ),
              const SizedBox(height: 12.0),
              ButtonNormalWidget(
                text: 'Import an account',
                onPressed: () {
                  Application.router.navigateTo(context, "/auth/import");
                },
                type: ButtonNormalType.primaryGhost,
              ),
              const SizedBox(height: kAppPaddingVerticalSize),
            ])
          ],
        ));
  }
}
