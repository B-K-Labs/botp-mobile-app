import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

// Base Button
abstract class AppButton extends StatelessWidget {
  const AppButton({Key? key}) : super(key: key);
}

// Normal Button
class AppNormalButton extends AppButton {
  final String text;
  final Function press;
  final Color primary, backgroundColor;
  final Color? borderColor;
  final String buttonType;

  const AppNormalButton({
    Key? key,
    required this.text,
    required this.press,
    required this.primary,
    required this.backgroundColor,
    this.borderColor,
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
                  color: borderColor != null ? (borderColor)! : backgroundColor,
                  width: 1,
                  style: BorderStyle.solid)),
          primary: primary,
          backgroundColor: backgroundColor,
          textStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.bold),
          padding: EdgeInsets.symmetric(
              vertical: 16, horizontal: buttonType == 'short' ? 8 : 32),
        ),
        onPressed: () => press(),
        child: Text(text),
      ),
    );
  }
}

// Sub Button
class AppSubButton extends AppButton {
  final String text;
  final Function press;
  final Color primary;

  const AppSubButton({
    Key? key,
    required this.text,
    required this.press,
    required this.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            textStyle: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.normal),
            primary: primary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: () => press(),
        child: Text(text));
  }
}

// Icon Button
class AppIconButton extends AppButton {
  final IconData iconData;
  final Color color;
  final Function onPressed;
  final double size;

  const AppIconButton(
      {Key? key,
      required this.iconData,
      required this.color,
      required this.onPressed,
      this.size = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: IconButton(
          padding: const EdgeInsets.all(0.0),
          constraints: const BoxConstraints(),
          icon: Icon(iconData, size: size),
          color: color,
          onPressed: () => onPressed(),
        ));
  }
}
