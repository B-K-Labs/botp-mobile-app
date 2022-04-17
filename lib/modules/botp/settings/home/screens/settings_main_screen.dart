import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_cubit.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_state.dart';
import 'package:botp_auth/modules/botp/settings/profile_view/screens/profile_view_screen.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const SettingsHomeBody());
  }
}

class SettingsHomeBody extends StatefulWidget {
  const SettingsHomeBody({Key? key}) : super(key: key);

  @override
  State<SettingsHomeBody> createState() => _SettingsHomeBodyState();
}

class _SettingsHomeBodyState extends State<SettingsHomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsHomeCubit>(
        create: (context) => SettingsHomeCubit(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_info(), const SizedBox(height: 60), _categories()],
        ));
  }

  Widget _info() {
    return BlocListener<SettingsHomeCubit, SettingsHomeState>(
        listener: (context, state) {
      final copyBcAddressStatus = state.copyBcAddressStatus;
      if (copyBcAddressStatus is SetClipboardStatusSuccessful) {
        showSnackBar(context, "Blockchain address copied");
      } else if (copyBcAddressStatus is SetClipboardStatusFailed) {
        showSnackBar(context, copyBcAddressStatus.exception.toString());
      }
    }, child: BlocBuilder<SettingsHomeCubit, SettingsHomeState>(
            builder: (context, state) {
      final fullName =
          state.fullName != null ? state.fullName! : state.guestName;
      return Column(children: [
        // Avatar
        state.avatarUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(state.avatarUrl!), radius: 80)
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
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(shortenBcAddress(state.bcAddress!)),
                    IconButton(
                        onPressed: () {
                          context.read<SettingsHomeCubit>().copyBcAddress();
                        },
                        icon: const Icon(Icons.copy))
                  ])
            : const CircularProgressIndicator(),
      ]);
    }));
  }

  Widget _categories() {
    List<Widget> _categoriesList = [
      _category(const Icon(Icons.person), "Profile", "Export, profile", () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileViewScreen()));
      }),
      _category(
          const Icon(Icons.dashboard), "Preferences", "Language, theme", () {}),
      _category(
          const Icon(Icons.security), "Security", "Password, sign out", () {}),
      _category(
          const Icon(Icons.info), "About", "Version, terms of services", () {}),
      _category(
          const Icon(Icons.arrow_back), "Sign out", "Sign out your account",
          () {
        UserData.setSessionData(SessionType.expired);
        Application.router.navigateTo(context, "/auth/signIn");
      })
    ];
    return Expanded(
        child: ListView.separated(
            itemCount: _categoriesList.length,
            itemBuilder: (context, index) => _categoriesList[index],
            // physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider()));
  }

  Widget _category(Icon icon, String title, String tooltip, Function() onTap) {
    return InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      Text(tooltip,
                          style: Theme.of(context).textTheme.bodyMedium)
                    ])),
                const Icon(Icons.arrow_forward_ios)
              ],
            )));
  }
}
