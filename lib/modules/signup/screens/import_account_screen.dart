import 'package:botp_auth/modules/signup/models/import_account_body.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';

class ImportAccountScreen extends StatelessWidget {
  const ImportAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: const Body());
  }
}
