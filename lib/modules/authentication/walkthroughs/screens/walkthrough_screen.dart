import "package:flutter/material.dart";

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(bottom: true, child: WalkThroughBody()));
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
    return Container();
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
