import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

// Button abstract
abstract class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);
}

class ButtonNoBorder extends Button {
  final String text;
  final Function press;
  final Color primary, backgroundColor;
  final String buttonType;

  const ButtonNoBorder({
    Key? key,
    required this.text,
    required this.press,
    required this.primary,
    required this.backgroundColor,
    this.buttonType = 'full',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonType == 'full' ? double.infinity : null,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadiusCircular),
              side: BorderSide(
                  color: backgroundColor, width: 1, style: BorderStyle.solid)),
          primary: primary,
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          padding: EdgeInsets.symmetric(
              vertical: 16, horizontal: buttonType == 'short' ? 8 : 32),
        ),
        onPressed: () => press(),
        child: Text(text),
      ),
    );
  }
}

class ButtonWithBorder extends Button {
  final String text;
  final Function press;
  final Color primary, backgroundColor, borderColor;
  final String buttonType;

  const ButtonWithBorder(
      {Key? key,
      required this.text,
      required this.press,
      required this.primary,
      required this.backgroundColor,
      required this.borderColor,
      this.buttonType = 'full'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonType == 'full' ? double.infinity : null,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadiusCircular),
              side: BorderSide(
                  color: borderColor, width: 1, style: BorderStyle.solid)),
          primary: primary,
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          padding: EdgeInsets.symmetric(
              vertical: 16, horizontal: buttonType == 'short' ? 8 : 32),
        ),
        onPressed: () => press(),
        child: Text(text),
      ),
    );
  }
}

class SubButton extends Button {
  final String text;
  final Function press;
  final Color primary;

  const SubButton({
    Key? key,
    required this.text,
    required this.press,
    required this.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            primary: primary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: () => press(),
        child: Text(text));
  }
}
