import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

// Note: ALl fields are using TextFormField

// Base Input Field
abstract class AppInputField extends StatefulWidget {
  const AppInputField({Key? key}) : super(key: key);
}

abstract class AppInputFieldState<T extends AppInputField> extends State<T> {
  late String value = '';

  @override
  Widget build(BuildContext context);
}

// Normal Input
class AppNormalInputField extends AppInputField {
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  final IconData? prefixIconData, suffixIconData;
  final Function? onTapSuffix;

  const AppNormalInputField({
    Key? key,
    this.hintText = '',
    required this.validator,
    required this.onChanged,
    this.prefixIconData,
    this.suffixIconData,
    this.onTapSuffix,
  }) : super(key: key);

  @override
  _AppNormalInputState createState() => _AppNormalInputState();
}

class _AppNormalInputState extends AppInputFieldState<AppNormalInputField> {
  @override
  Widget build(BuildContext context) {
    // Prefix icon
    Icon? icon = widget.prefixIconData != null
        ? Icon((widget.prefixIconData)!, color: AppColors.grayColor03)
        : null;
    // Suffix icon
    Icon? suffixIcon = widget.suffixIconData != null
        ? Icon((widget.suffixIconData)!, color: AppColors.grayColor03)
        : null;
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        suffixIcon: suffixIcon,
        hintText: widget.hintText,
      ),
    );
  }
}

// Password Input Field
class AppPasswordInputField extends AppInputField {
  final String hintText;
  // final String? Function(String?)? validator;
  // final Function(String?) onChanged;

  const AppPasswordInputField({
    Key? key,
    this.hintText = '',
    // required this.validator,
    // required this.onChanged
  }) : super(key: key);

  @override
  _AppPasswordInputFieldState createState() => _AppPasswordInputFieldState();
}

class _AppPasswordInputFieldState
    extends AppInputFieldState<AppPasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blackColor,
      obscureText: _obscureText,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: _obscureText
                ? const Icon(Icons.visibility, color: AppColors.grayColor03)
                : const Icon(Icons.visibility_off,
                    color: AppColors.grayColor03),
          ),
          hintText: value,
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.grayColor03, width: 1.0),
            borderRadius: BorderRadius.circular(kBorderRadiusCircular),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.grayColor04, width: 2.0),
            borderRadius: BorderRadius.circular(kBorderRadiusCircular),
          )),
    );
  }
}

// ============================== Migrate to the new one above

// Password Input Field
class AppPasswordInput extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  final IconData? prefixIconData;

  const AppPasswordInput(
      {Key? key,
      this.hintText = '',
      required this.validator,
      required this.onChanged,
      this.prefixIconData})
      : super(key: key);

  @override
  _AppPasswordInputState createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// ============
class InputForm2 extends StatelessWidget {
  final String hintText;

  const InputForm2({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TextFieldContainer(
        textField: TextField(
      style: const TextStyle(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person, color: AppColors.primaryColor),
          hintText: hintText,
          border: InputBorder.none),
    ));
  }
}

class InputFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  const InputFormField({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TextFieldContainer(
        textField: TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          icon: const Icon(Icons.person, color: AppColors.primaryColor),
          hintText: hintText,
          border: InputBorder.none),
      validator: validator,
      onChanged: onChanged,
    ));
  }
}

class PasswordField extends StatelessWidget {
  final String hintText;

  const PasswordField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TextFieldContainer(
        textField: TextField(
      obscureText: true,
      style: const TextStyle(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          icon: const Icon(Icons.lock, color: AppColors.primaryColor),
          suffixIcon:
              const Icon(Icons.visibility, color: AppColors.primaryColor),
          hintText: hintText,
          border: InputBorder.none),
    ));
  }
}

class _TextFieldContainer extends StatelessWidget {
  final Widget textField;
  final Color? borderColor;

  const _TextFieldContainer(
      {Key? key, required this.textField, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColorLight,
        borderRadius: BorderRadius.circular(kBorderRadiusCircular),
      ),
      child: textField,
    );
  }
}
