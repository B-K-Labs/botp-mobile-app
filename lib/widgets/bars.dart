import "package:flutter/material.dart";

class AppBarWidget extends StatelessWidget {
  final AppBarType type;

  const AppBarWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
