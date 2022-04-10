import 'package:botp_auth/core/storage/user_data.dart';
import "package:flutter/material.dart";

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: SafeArea(child: ProfileViewBody()));
  }
}

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({Key? key}) : super(key: key);

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Neh"));
  }
}
