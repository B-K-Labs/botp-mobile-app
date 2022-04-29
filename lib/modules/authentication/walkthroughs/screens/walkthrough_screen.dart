import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/widgets/button.dart';
import "package:flutter/material.dart";

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: WalkThroughBody()));
  }
}

class WalkThroughBody extends StatefulWidget {
  const WalkThroughBody({Key? key}) : super(key: key);

  @override
  State<WalkThroughBody> createState() => _WalkThroughBodyState();
}

class _WalkThroughBodyState extends State<WalkThroughBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [_walkThroughs(), _actionButton()]);
  }

  Widget _walkThroughs() {
    return Container();
  }

  Widget _actionButton() {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalSize,
            vertical: kAppPaddingVerticalSize),
        child: Row(children: [
          Expanded(
              child: ButtonNormalWidget(
                  text: "SKip",
                  onPressed: () {
                    Application.router.navigateTo(context, "/auth/init");
                  })),
          const SizedBox(width: kAppPaddingBetweenItemSmallSize),
          Expanded(
              child: ButtonNormalWidget(
                  text: "Next",
                  onPressed: () {
                    Application.router.navigateTo(context, "/auth/init");
                  }))
        ]));
  }
}

List<Map<String, String>> walkThroughItemsList = [
  {
    "image": "assets/images/temp/botp_temp.png",
    "title": "Better Two-factor authentication",
    "description": "Directly confirm or reject the transaction in 2FA",
  },
  {
    "image": "assets/images/temp/botp_temp.png",
    "title": "More transparent with Blockchain",
    "description": "Lookup transaction right from Blockchain",
  },
  {
    "image": "assets/images/temp/botp_temp.png",
    "title": "Recoverable account",
    "description": "Back up once, import everywhere",
  },
];
