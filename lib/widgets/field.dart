import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

class RoundedInputFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  const RoundedInputFormField({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      style: const TextStyle(fontWeight: FontWeight.normal),
      decoration: const InputDecoration(
          icon: Icon(Icons.person, color: kPrimaryColor),
          hintText: "Your private key",
          border: InputBorder.none),
      validator: validator,
      onChanged: onChanged,
    ));
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;

  const RoundedInputField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextFieldContainer(
        child: TextField(
      style: TextStyle(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          icon: Icon(Icons.person, color: kPrimaryColor),
          hintText: "Your private key",
          border: InputBorder.none),
    ));
  }
}

class RoundedPasswordField extends StatelessWidget {
  final String hintText;

  const RoundedPasswordField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      style: const TextStyle(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          icon: const Icon(Icons.lock, color: kPrimaryColor),
          suffixIcon: const Icon(Icons.visibility, color: kPrimaryColor),
          hintText: hintText,
          border: InputBorder.none),
    ));
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(kBorderRadiusCircular),
      ),
      child: child,
    );
  }
}
