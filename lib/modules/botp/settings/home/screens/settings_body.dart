import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_cubit.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_state.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsHomeCubit>(
        create: (context) => SettingsHomeCubit(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_info(), const SizedBox(height: 48.0), _categories()],
        ));
  }

  Widget _info() {
    return BlocListener<SettingsHomeCubit, SettingsHomeState>(
        listener: (context, state) {
      final copyBcAddressStatus = state.copyBcAddressStatus;
      if (copyBcAddressStatus is SetClipboardStatusSuccess) {
        showSnackBar(
            context, "Blockchain address copied.", SnackBarType.success);
      } else if (copyBcAddressStatus is SetClipboardStatusFailed) {
        showSnackBar(context, copyBcAddressStatus.exception.toString());
      }
    }, child: BlocBuilder<SettingsHomeCubit, SettingsHomeState>(
            builder: (context, state) {
      final fullName =
          state.fullName != null ? state.fullName! : state.guestName;
      return Column(children: [
        const SizedBox(height: kAppPaddingTopSize),
        state.bcAddress != null && state.fullName != null
            ? SettingsHomeInfo(
                avatarUrl: state.avatarUrl,
                fullName: state.fullName!,
                bcAddress: state.bcAddress!)
            : SkeletonItem(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            width: 120,
                            height: 120,
                            borderRadius: BorderRadius.circular(100))),
                    const SizedBox(height: 24.0),
                    SkeletonLine(
                        style: SkeletonLineStyle(
                            borderRadius:
                                BorderRadius.circular(BorderRadiusSize.normal),
                            alignment: AlignmentDirectional.center,
                            height: 28.0,
                            randomLength: true,
                            minLength: 200,
                            maxLength: 300)),
                    const SizedBox(height: 12.0),
                    SkeletonLine(
                        style: SkeletonLineStyle(
                            borderRadius:
                                BorderRadius.circular(BorderRadiusSize.small),
                            alignment: AlignmentDirectional.center,
                            height: 25.0,
                            width: 200)),
                  ]))
      ]);
    }));
  }

  Widget _categories() {
    List<Widget> _categoriesList = [
      _category(const Icon(Icons.person), "Account", "Account, Profile", () {}),
      _category(const Icon(Icons.security), "Security",
          "Password, Biometrics, Sign-out", () {}),
      _category(const Icon(Icons.settings), "System",
          "Preferences, Notifications", () {}),
      _category(
          const Icon(Icons.info), "About", "Version, terms of services", () {}),
      _category(
          const Icon(Icons.arrow_back), "Sign out", "Sign out your account",
          () async {
        await context.read<SessionCubit>().signOut();
        Application.router.navigateTo(context, "/");
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
