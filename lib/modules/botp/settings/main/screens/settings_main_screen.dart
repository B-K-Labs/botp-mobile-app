import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        ),
        body: const SafeArea(
            minimum: EdgeInsets.all(kPaddingSafeArea), child: SettingsBody()));
  }
}

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_info(), const SizedBox(height: 60), _categories()],
    );
  }

  Widget _info() {
    return FutureBuilder<CredentialAccountDataModel?>(
        future: UserData.getCredentialAccountData(),
        builder: (BuildContext context,
            AsyncSnapshot<CredentialAccountDataModel?> snapshot) {
          return Column(children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.printed.com/blog/wp-content/uploads/2016/06/quiz-serious-cat.png"),
              radius: 80,
            ),
            const SizedBox(height: 18.0),
            Text("Nguyen Huynh Huu Khiem",
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 12.0),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1)),
                child: snapshot.hasData
                    ? Text(snapshot.data!.bcAddress)
                    : Text("bcAddress"))
          ]);
        });
  }

  Widget _categories() {
    List<Widget> _categoriesList = [
      _category(Icon(Icons.person), "Account", "Export, profile", () {}),
      _category(Icon(Icons.adjust), "Preferences", "Language, theme", () {}),
      _category(Icon(Icons.security), "Security", "Password, sign out", () {}),
      _category(Icon(Icons.info), "About", "Version, terms of services", () {})
    ];
    return Expanded(
        child: ListView.separated(
            itemCount: _categoriesList.length,
            itemBuilder: (context, index) => _categoriesList[index],
            separatorBuilder: (context, index) => const Divider()));
  }

  Widget _category(Icon icon, String title, String tooltip, Function() onTap) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20.0),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(tooltip, style: Theme.of(context).textTheme.bodyMedium)
                ])),
            Icon(Icons.arrow_right)
          ],
        ));
  }
}
