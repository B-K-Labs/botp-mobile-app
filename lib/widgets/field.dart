import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

// Note: ALl fields are using TextFormField
// Normal Input
class AppNormalInputField extends StatefulWidget {
  final String hintText;
  // final String? Function(String?)? validator;
  // final Function(String?) onChanged;
  final IconData? iconData, suffixIconData;
  final Function? onTapSuffix;

  const AppNormalInputField({
    Key? key,
    this.hintText = '',
    // required this.validator,
    // required this.onChanged,
    this.iconData,
    this.suffixIconData,
    this.onTapSuffix,
  }) : super(key: key);

  @override
  _AppNormalInputState createState() => _AppNormalInputState();
}

class _AppNormalInputState extends State<AppNormalInputField> {
  @override
  Widget build(BuildContext context) {
    // Style
    TextStyle? _style = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.normal);
    // Prefix icon
    Widget? _icon = widget.iconData != null
        ? Icon((widget.iconData)!, color: AppColors.grayColor03)
        : null;
    // Suffix icon
    Widget? _suffixIcon = widget.suffixIconData != null
        ? GestureDetector(
            onTap: widget.onTapSuffix != null
                ? () {
                    (widget.onTapSuffix)!();
                  }
                : null,
            child: Icon(widget.suffixIconData, color: AppColors.grayColor03))
        : null;
    // Borders5
    OutlineInputBorder _border = OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grayColor02, width: 1.0),
        borderRadius: BorderRadius.circular(AppBorderRadiusCircular.large));
    OutlineInputBorder _focusedBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(AppBorderRadiusCircular.large));
    OutlineInputBorder _errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.redColor, width: 2.0),
      borderRadius: BorderRadius.circular(AppBorderRadiusCircular.large),
    );
    // Return final text field
    return TextFormField(
      cursorColor: AppColors.primaryColor,
      style: _style,
      decoration: InputDecoration(
        icon: _icon,
        suffixIcon: _suffixIcon,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(16.0),
        border: _border,
        focusedBorder: _focusedBorder,
        errorBorder: _errorBorder,
      ),
    );
  }
}

// Password Input Field
class AppPasswordInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  // final String? Function(String?)? validator;
  // final Function(String?) onChanged;

  const AppPasswordInputField({
    Key? key,
    required this.controller,
    this.hintText = '',
    // required this.validator,
    // required this.onChanged
  }) : super(key: key);

  @override
  _AppPasswordInputFieldState createState() => _AppPasswordInputFieldState();
}

class _AppPasswordInputFieldState extends State<AppPasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Style
    TextStyle? _style = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.normal);
    // Suffix Icon
    Widget _suffixIcon = GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: _obscureText
          ? const Icon(Icons.visibility, color: AppColors.grayColor03)
          : const Icon(Icons.visibility_off, color: AppColors.grayColor03),
    );
    // Borders
    OutlineInputBorder _border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.grayColor02, width: 1.0),
      borderRadius: BorderRadius.circular(AppBorderRadiusCircular.large),
    );
    OutlineInputBorder _focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      borderRadius: BorderRadius.circular(AppBorderRadiusCircular.large),
    );
    OutlineInputBorder _errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.redColor, width: 2.0),
      borderRadius: BorderRadius.circular(AppBorderRadiusCircular.large),
    );

    // Return final text field
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColors.primaryColor,
      obscureText: _obscureText,
      style: _style,
      decoration: InputDecoration(
        suffixIcon: _suffixIcon,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(16.0),
        border: _border,
        focusedBorder: _focusedBorder,
        errorBorder: _errorBorder,
      ),
    );
  }
}
