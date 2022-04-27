import 'package:flutter/material.dart';
import 'package:botp_auth/constants/common.dart';

// Normal Button
class ButtonNormalWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonNormalType type;
  final ButtonNormalSize size;

  const ButtonNormalWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.type = ButtonNormalType.primary,
      this.size = ButtonNormalSize.full})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Width
    final _width = size == ButtonNormalSize.full ? double.infinity : null;
    // - Colors
    final Color? _borderColor;
    final Color _primary;
    final Color? _backgroundColor;
    if (onPressed == null) {
      _borderColor = null;
      _primary = Theme.of(context).colorScheme.onSurfaceVariant;
      _backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
    } else {
      switch (type) {
        case ButtonNormalType.primaryOutlined:
          _borderColor = Theme.of(context).colorScheme.primary;
          _primary = Theme.of(context).colorScheme.primary;
          _backgroundColor = null;
          break;
        case ButtonNormalType.primaryGhost:
          _borderColor = null;
          _primary = Theme.of(context).colorScheme.primary;
          _backgroundColor = null;
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
        case ButtonNormalType.primary:
        default:
          _borderColor = null;
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
        vertical: 16, horizontal: type == ButtonNormalSize.short ? 8 : 32);

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
  final ButtonTextType? type;

  const ButtonTextWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonTextType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button theme
    // - Color
    final _primary = type == ButtonTextType.primary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
    // - Text
    final _textStyle = Theme.of(context).textTheme.bodyText2;

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
    final double _size = size == ButtonIconSize.big ? 36 : 24;
    // - Colors
    final Color? _borderColor;
    final Color _primary; // Icon color
    final Color? _backgroundColor;
    switch (type) {
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
      case ButtonIconType.primaryOutlined:
      default:
        _borderColor = Theme.of(context).colorScheme.primary;
        _primary = Theme.of(context).colorScheme.primary;
        _backgroundColor = null;
        break;
    }
    // - Shape
    final _borderRadius = BorderRadius.circular(
        shape == ButtonIconShape.round ? 1000 : BorderRadiusSize.normal);
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
  }
}
