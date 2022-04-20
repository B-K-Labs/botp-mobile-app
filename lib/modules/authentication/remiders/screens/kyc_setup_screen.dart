import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/button.dart';
import "package:flutter/material.dart";

class ReminderKYCSetupScreen extends StatelessWidget {
  const ReminderKYCSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ReminderKYCSetupBody extends StatelessWidget {
  const ReminderKYCSetupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kAppPaddingSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(children: [
            const SizedBox(height: 104.0),
            Text("Setup KYC",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 48.0),
            Text(
              "Setup KYC",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: Image.asset("assets/images/temp/botp_temp.png",
                  scale: 1, fit: BoxFit.fitWidth),
            )
          ]),
          Column(
            children: [
              Row(children: <Widget>[
                Expanded(
                    child: ButtonNormalWidget(
                  text: "Skip",
                  buttonType: ButtonNormalType.secondaryOutlined,
                  onPressed: () {
                    // TODO: skip
                  },
                )),
                const SizedBox(
                  width: kAppItemPaddingSize,
                ),
                Expanded(
                    child: ButtonNormalWidget(
                        text: "Set up now",
                        buttonType: ButtonNormalType.primary,
                        onPressed: () {
                          // TODO: setup KYC
                        })),
              ]),
              const SizedBox(height: kAppPaddingSize)
            ],
          )
        ],
      ),
    );
  }
}
