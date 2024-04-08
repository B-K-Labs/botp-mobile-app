import 'package:flutter/material.dart';
import 'package:botp_auth/constants/common.dart';

// Note: ALl fields are stateful and based on TextFormField
// Normal Input
class FieldNormalWidget extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;
  final IconData? prefixIconData, suffixIconData;
  final VoidCallback? onTapPrefixIcon, onTapSuffixIcon;
  final TextEditingController? controller;
  final bool autofocus;
  final TextInputAction textInputAction;

  const FieldNormalWidget({
    Key? key,
    this.controller,
    this.hintText = '',
    this.initialValue,
    required this.validator,
    required this.onChanged,
    this.prefixIconData,
    this.suffixIconData,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.autofocus = false,
    required this.textInputAction,
  }) : super(key: key);

  @override
  _FieldNormalWidgetState createState() => _FieldNormalWidgetState();
}

class _FieldNormalWidgetState extends State<FieldNormalWidget> {
  @override
  Widget build(BuildContext context) {
    // Field theme
    // - Colors
    final Color iconsColor = Theme.of(context).colorScheme.outline;
    final Color cursorColor = Theme.of(context).colorScheme.onSurface;
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.outline, width: 1.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    // - Text
    final TextStyle? style = Theme.of(context).textTheme.bodyMedium;
    // - Icons
    Widget? prefixIcon = widget.prefixIconData != null
        ? GestureDetector(
            onTap: widget.onTapPrefixIcon,
            child: Icon((widget.prefixIconData)!, color: iconsColor))
        : null;
    Widget? suffixIcon = widget.suffixIconData != null
        ? GestureDetector(
            onTap: widget.onTapSuffixIcon,
            child: Icon(widget.suffixIconData, color: iconsColor))
        : null;
    // - Padding
    const padding = EdgeInsets.all(16.0);

    return TextFormField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: cursorColor,
      style: style,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: widget.hintText,
        contentPadding: padding,
        border: border,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
      ),
    );
  }
}

// Password Input Field
class FieldPasswordWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? initialValue;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;
  final bool autofocus;
  final TextInputAction textInputAction;

  const FieldPasswordWidget(
      {Key? key,
      this.controller,
      this.hintText = '',
      this.initialValue,
      required this.validator,
      required this.onChanged,
      this.autofocus = false,
      required this.textInputAction})
      : super(key: key);

  @override
  _FieldPasswordWidgetState createState() => _FieldPasswordWidgetState();
}

class _FieldPasswordWidgetState extends State<FieldPasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Field theme
    // - Colors
    final Color iconsColor = Theme.of(context).colorScheme.outline;
    final Color cursorColor = Theme.of(context).colorScheme.onSurface;
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.outline, width: 1.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    // - Text
    final TextStyle? style = Theme.of(context).textTheme.bodyMedium;
    // - Suffix icon
    Widget suffixIcon = GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,
          color: iconsColor),
    );
    // - Padding
    const padding = EdgeInsets.all(16.0);

    // Return final text field
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: cursorColor,
      obscureText: _obscureText,
      style: style,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: widget.hintText,
        contentPadding: padding,
        border: border,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
      ),
    );
  }
}
