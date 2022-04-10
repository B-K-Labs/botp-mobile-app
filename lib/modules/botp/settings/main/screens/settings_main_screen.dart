import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/modules/botp/settings/main/cubit/settings_main_cubit.dart';
import 'package:botp_auth/modules/botp/settings/main/cubit/settings_main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: SafeArea(
            minimum: const EdgeInsets.all(kPaddingSafeArea),
            child: BlocProvider(
                create: (context) => SettingsMainCubit(),
                child: const SettingsBody())));
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
    return BlocBuilder<SettingsMainCubit, SettingsMainState>(
        builder: (context, state) {
      final fullName =
          state.fullName != null ? state.fullName! : state.guestName;
      return Column(children: [
        // Avatar
        state.avatarUrl != null
            ? const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.printed.com/blog/wp-content/uploads/2016/06/quiz-serious-cat.png"),
                radius: 80,
              )
            : CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 80,
              ),
        const SizedBox(height: 18.0),
        // Fullname
        Text(fullName, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 12.0),
        // Blockchain address
        state.bcAddress != null
            ? Text(state.bcAddress!)
            : const CircularProgressIndicator(),
      ]);
    });
  }

  Widget _categories() {
    List<Widget> _categoriesList = [
      _category(const Icon(Icons.person), "Account", "Export, profile", () {}),
      _category(
          const Icon(Icons.adjust), "Preferences", "Language, theme", () {}),
      _category(
          const Icon(Icons.security), "Security", "Password, sign out", () {}),
      _category(
          const Icon(Icons.info), "About", "Version, terms of services", () {})
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
