import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;

  const RoundedInputField(
      {Key? key, required this.hintText,})
      : super(key: key);

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

  const RoundedPasswordField(
      {Key? key, required this.hintText,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextFieldContainer(
        child: TextField(
          obscureText: true,
          style: TextStyle(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: kPrimaryColor),
              suffixIcon: Icon(Icons.visibility, color: kPrimaryColor),
              hintText: "Password",
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