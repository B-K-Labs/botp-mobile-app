import 'package:flutter/material.dart';
import 'package:botp_auth/constants/theme.dart';

// Normal Button
class ButtonNormalWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonNormalType buttonType;
  final ButtonNormalSize buttonSize;

  const ButtonNormalWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.buttonType = ButtonNormalType.primary,
      this.buttonSize = ButtonNormalSize.full})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Width
    final _width = buttonSize == ButtonNormalSize.full ? double.infinity : null;
    // - Colors
    final Color? _borderColor;
    final Color _primary;
    final Color? _backgroundColor;
    if (onPressed == null) {
      _borderColor = null;
      _primary = Theme.of(context).colorScheme.onSurfaceVariant;
      _backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
    } else {
      switch (buttonType) {
        case ButtonNormalType.primary:
          _borderColor = null;
          _primary = Theme.of(context).colorScheme.onPrimary;
          _backgroundColor = Theme.of(context).colorScheme.primary;
          break;
        case ButtonNormalType.primaryOutlined:
          _borderColor = Theme.of(context).colorScheme.primary;
          _primary = Theme.of(context).colorScheme.primary;
          _backgroundColor = null;
          break;
        case ButtonNormalType.primaryGhost:
          _borderColor = null;
          _primary = Theme.of(context).colorScheme.primary;
          _backgroundColor = null; // TODO: How to calculate it ?
          break;
        case ButtonNormalType.secondaryOutlined:
          _borderColor = Theme.of(context).colorScheme.outline;
          _primary = Theme.of(context).colorScheme.onSurfaceVariant;
          _backgroundColor = null;
          break;
        case ButtonNormalType.secondaryGhost:
          _borderColor = null;
          _primary = Theme.of(context).colorScheme.onSurfaceVariant;
          _backgroundColor = null;
          break;
        case ButtonNormalType.error:
          _borderColor = Theme.of(context).colorScheme.error;
          _primary = Theme.of(context).colorScheme.onError;
          _backgroundColor = Theme.of(context).colorScheme.error;
          break;
        case ButtonNormalType.errorOutlined:
          _borderColor = Theme.of(context).colorScheme.error;
          _primary = Theme.of(context).colorScheme.error;
          _backgroundColor = null;
          break;
        case ButtonNormalType.disabled:
          _borderColor = null;
          _primary = Theme.of(context).colorScheme.onSurfaceVariant;
          _backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
          break;
        default: // Primary
          _borderColor = Theme.of(context).colorScheme.primary;
          _primary = Theme.of(context).colorScheme.onPrimary;
          _backgroundColor = Theme.of(context).colorScheme.primary;
          break;
      }
    }

    final _side = _borderColor == null
        ? BorderSide.none
        : BorderSide(color: _borderColor, width: 1.0, style: BorderStyle.solid);
    // - Text
    final _textStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    // - Padding
    final _padding = EdgeInsets.symmetric(
        vertical: 16,
        horizontal: buttonType == ButtonNormalSize.short ? 8 : 32);

    // Return button
    return SizedBox(
      width: _width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
          ),
          side: _side,
          primary: _primary,
          backgroundColor: _backgroundColor,
          textStyle: _textStyle,
          padding: _padding,
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

  const ButtonTextWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Color
    final _primary = Theme.of(context).colorScheme.primary;
    // - Text
    final _textStyle = Theme.of(context).textTheme.bodyText1;

    return TextButton(
        style: TextButton.styleFrom(
            textStyle: _textStyle,
            primary: _primary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: onPressed,
        child: Text(text));
  }
}

// Icon Button
class ButtonIconWidget extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final ButtonIconType buttonType;
  final ButtonIconSize buttonSize;
  final ButtonIconShape buttonShape;

  const ButtonIconWidget(
      {Key? key,
      required this.iconData,
      required this.onTap,
      this.buttonType = ButtonIconType.primaryOutlined,
      this.buttonSize = ButtonIconSize.normal,
      this.buttonShape = ButtonIconShape.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Size
    final double _size = buttonSize == ButtonIconSize.big ? 36 : 24;
    // - Colors
    final Color? _borderColor;
    final Color _primary; // Icon color
    final Color? _backgroundColor;
    switch (buttonType) {
      case ButtonIconType.primaryOutlined:
        _borderColor = Theme.of(context).colorScheme.primary;
        _primary = Theme.of(context).colorScheme.primary;
        _backgroundColor = null;
        break;
      case ButtonIconType.secondaryGhost:
        _borderColor = Theme.of(context).colorScheme.background;
        _primary = Theme.of(context).colorScheme.onSurfaceVariant;
        _backgroundColor = null;
        break;
      case ButtonIconType.error:
        _borderColor = null;
        _primary = Theme.of(context).colorScheme.onError;
        _backgroundColor = Theme.of(context).colorScheme.error;
        break;
      default: // Primary outlined
        _borderColor = Theme.of(context).colorScheme.primary;
        _primary = Theme.of(context).colorScheme.primary;
        _backgroundColor = null;
    }
    // - Shape
    final _borderRadius = BorderRadius.circular(
        buttonShape == ButtonIconShape.round ? 1000 : BorderRadiusSize.normal);
    // - Padding
    const _padding = EdgeInsets.all(6.0);

    return Ink(
        decoration: BoxDecoration(
            border: _borderColor != null
                ? Border.all(color: _borderColor, width: 1.0)
                : null,
            color: _backgroundColor,
            borderRadius: _borderRadius),
        child: InkWell(
            borderRadius: _borderRadius,
            onTap: onTap,
            child: Padding(
                padding: _padding,
                child: Icon(
                  iconData,
                  size: _size,
                  color: _primary,
                ))));
    // return SizedBox(
    //     height: size,
    //     width: size,
    //     child: IconButton(
    //       padding: const EdgeInsets.all(0.0),
    //       constraints: const BoxConstraints(),
    //       icon: Icon(iconData, size: size),
    //       color: color,
    //       onPressed: onPressed,
    //     ));
  }
}
