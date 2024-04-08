import 'package:botp_auth/constants/common.dart';
import 'package:flutter/material.dart';

// Normal Button
class ButtonNormalWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonNormalType type;
  final ButtonNormalMode mode;
  final ButtonNormalSize size;

  const ButtonNormalWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.type = ButtonNormalType.primary,
      this.mode = ButtonNormalMode.full,
      this.size = ButtonNormalSize.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Width
    final width = mode == ButtonNormalMode.full ? double.infinity : null;
    // - Colors
    final Color? borderColor;
    final Color primary;
    final Color? backgroundColor;
    if (onPressed == null) {
      borderColor = null;
      primary = Theme.of(context).colorScheme.onSurfaceVariant;
      backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
    } else {
      switch (type) {
        case ButtonNormalType.primaryOutlined:
          borderColor = Theme.of(context).colorScheme.primary;
          primary = Theme.of(context).colorScheme.primary;
          backgroundColor = null;
          break;
        case ButtonNormalType.primaryGhost:
          borderColor = null;
          primary = Theme.of(context).colorScheme.primary;
          backgroundColor = null;
          break;
        case ButtonNormalType.secondaryOutlined:
          borderColor = Theme.of(context).colorScheme.outline;
          primary = Theme.of(context).colorScheme.onSurfaceVariant;
          backgroundColor = null;
          break;
        case ButtonNormalType.secondaryGhost:
          borderColor = null;
          primary = Theme.of(context).colorScheme.onSurfaceVariant;
          backgroundColor = null;
          break;
        case ButtonNormalType.error:
          borderColor = Theme.of(context).colorScheme.error;
          primary = Theme.of(context).colorScheme.onError;
          backgroundColor = Theme.of(context).colorScheme.error;
          break;
        case ButtonNormalType.errorOutlined:
          borderColor = Theme.of(context).colorScheme.error;
          primary = Theme.of(context).colorScheme.error;
          backgroundColor = null;
          break;
        case ButtonNormalType.disabled:
          borderColor = null;
          primary = Theme.of(context).colorScheme.onSurfaceVariant;
          backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
          break;
        case ButtonNormalType.primary:
        default:
          borderColor = null;
          primary = Theme.of(context).colorScheme.onPrimary;
          backgroundColor = Theme.of(context).colorScheme.primary;
          break;
      }
    }

    final side = borderColor == null
        ? BorderSide.none
        : BorderSide(color: borderColor, width: 1.0, style: BorderStyle.solid);
    // - Text
    final textStyle = size == ButtonNormalSize.normal
        ? Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold);
    // - Padding
    final padding = size == ButtonNormalSize.normal
        ? EdgeInsets.symmetric(
            vertical: 16, horizontal: type == ButtonNormalMode.short ? 8 : 32)
        : EdgeInsets.symmetric(
            vertical: 8, horizontal: type == ButtonNormalMode.short ? 4 : 16);

    // Return button
    return SizedBox(
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
          ),
          side: side,
          backgroundColor: backgroundColor,
          textStyle: textStyle,
          padding: padding,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

// Text Button
class ButtonTextWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonTextType? type;
  final IconData? iconData;

  const ButtonTextWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonTextType.primary,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Color
    final primary = type == ButtonTextType.primary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
    // - Text
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return iconData != null
        ? InkWell(
            onTap: onPressed,
            child: Row(children: [
              Text(text, style: textStyle?.copyWith(color: primary)),
              const SizedBox(width: 8.0),
              Icon(iconData, color: primary)
            ]))
        : TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primary,
              textStyle: textStyle,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: Text(text));
  }
}

// Icon Button
class ButtonIconWidget extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final ButtonIconType type;
  final ButtonIconSize size;
  final ButtonIconShape shape;

  const ButtonIconWidget(
      {Key? key,
      required this.iconData,
      required this.onTap,
      this.type = ButtonIconType.primaryOutlined,
      this.size = ButtonIconSize.normal,
      this.shape = ButtonIconShape.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Size
    final double size = this.size == ButtonIconSize.big ? 36 : 24;
    // - Colors
    final Color? borderColor;
    final Color primary; // Icon color
    final Color? backgroundColor;
    switch (type) {
      case ButtonIconType.secondaryGhost:
        borderColor = Theme.of(context).colorScheme.background;
        primary = Theme.of(context).colorScheme.onSurfaceVariant;
        backgroundColor = null;
        break;
      case ButtonIconType.error:
        borderColor = null;
        primary = Theme.of(context).colorScheme.onError;
        backgroundColor = Theme.of(context).colorScheme.error;
        break;
      case ButtonIconType.primaryOutlined:
      default:
        borderColor = Theme.of(context).colorScheme.primary;
        primary = Theme.of(context).colorScheme.primary;
        backgroundColor = null;
        break;
    }
    // - Shape
    final borderRadius = BorderRadius.circular(
        shape == ButtonIconShape.round ? 1000 : BorderRadiusSize.normal);
    // - Padding
    const padding = EdgeInsets.all(6.0);

    return Container(
        decoration: BoxDecoration(
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1.0)
                : null,
            borderRadius: borderRadius,
            color: backgroundColor),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: borderRadius,
                onTap: onTap,
                child: Padding(
                    padding: padding,
                    child: Icon(
                      iconData,
                      size: size,
                      color: primary,
                    )))));
  }
}
