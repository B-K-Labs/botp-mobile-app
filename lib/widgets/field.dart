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
  }) : super(key: key);

  @override
  _FieldNormalWidgetState createState() => _FieldNormalWidgetState();
}

class _FieldNormalWidgetState extends State<FieldNormalWidget> {
  @override
  Widget build(BuildContext context) {
    // Field theme
    // - Colors
    final Color _iconsColor = Theme.of(context).colorScheme.outline;
    final Color _cursorColor = Theme.of(context).colorScheme.onSurface;
    OutlineInputBorder _border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.outline, width: 1.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder _focusedBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder _errorBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    // - Text
    final TextStyle? _style = Theme.of(context).textTheme.bodyText1;
    // - Icons
    Widget? _prefixIcon = widget.prefixIconData != null
        ? GestureDetector(
            onTap: widget.onTapPrefixIcon,
            child: Icon((widget.prefixIconData)!, color: _iconsColor))
        : null;
    Widget? _suffixIcon = widget.suffixIconData != null
        ? GestureDetector(
            onTap: widget.onTapSuffixIcon,
            child: Icon(widget.suffixIconData, color: _iconsColor))
        : null;
    // - Padding
    const _padding = EdgeInsets.all(16.0);

    return TextFormField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: _cursorColor,
      style: _style,
      decoration: InputDecoration(
        prefixIcon: _prefixIcon,
        suffixIcon: _suffixIcon,
        hintText: widget.hintText,
        contentPadding: _padding,
        border: _border,
        focusedBorder: _focusedBorder,
        errorBorder: _errorBorder,
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

  const FieldPasswordWidget(
      {Key? key,
      this.controller,
      this.hintText = '',
      this.initialValue,
      required this.validator,
      required this.onChanged,
      this.autofocus = false})
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
    final Color _iconsColor = Theme.of(context).colorScheme.outline;
    final Color _cursorColor = Theme.of(context).colorScheme.onSurface;
    OutlineInputBorder _border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.outline, width: 1.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder _focusedBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    OutlineInputBorder _errorBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
      borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
    );
    // - Text
    final TextStyle? _style = Theme.of(context).textTheme.bodyText1;
    // - Suffix icon
    Widget _suffixIcon = GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,
          color: _iconsColor),
    );
    // - Padding
    const _padding = EdgeInsets.all(16.0);

    // Return final text field
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: _cursorColor,
      obscureText: _obscureText,
      style: _style,
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        suffixIcon: _suffixIcon,
        hintText: widget.hintText,
        contentPadding: _padding,
        border: _border,
        focusedBorder: _focusedBorder,
        errorBorder: _errorBorder,
      ),
    );
  }
}
