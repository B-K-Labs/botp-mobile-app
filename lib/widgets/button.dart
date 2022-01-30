import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color primary, backgroundColor;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      required this.primary,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadiusCircular),
        child: TextButton(
            style: TextButton.styleFrom(
              primary: primary,
              backgroundColor: backgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            onPressed: () => press(),
            child: Text(text)),
      ),
    );
  }
}
