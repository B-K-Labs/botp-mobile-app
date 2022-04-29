import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_cubit.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_state.dart';
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
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _info(),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            _categoriesList()
          ],
        )));
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
      return Column(children: [
        const SizedBox(height: kAppPaddingVerticalSize),
        state.loadUserDataStatus is LoadUserDataStatusSuccess
            ? SettingsHomeInfo(
                avatarUrl: state.avatarUrl,
                fullName: state.fullName ?? "Guest",
                bcAddress: state.bcAddress!,
                onTapBcAddress: () {
                  context.read<SettingsHomeCubit>().copyBcAddress();
                },
              )
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

  Widget _categoriesList() {
    return BlocBuilder<SettingsHomeCubit, SettingsHomeState>(
        builder: (context, state) {
      return state.loadUserDataStatus is LoadUserDataStatusSuccess
          ? _generateSettingsCategoriesList()
          : Container();
      // Expanded(
      //     child: Stack(children: [
      //       // Positioned.fill(child: _generateSettingsShadowCategoriesList()),
      //       _generateSettingsCategoriesList()
      //     ]))
    });
    ;
  }

  // Widget _generateSettingsShadowCategoriesList() {
  //   List<Widget> shadowCategoriesList =
  //       List<Widget>.generate(4, (_) => _generateShadowSettingsCategoryItem());
  //   return ListView.separated(
  //     padding:
  //         const EdgeInsets.symmetric(vertical: kAppPaddingBetweenItemSmallSize),
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     itemBuilder: (_, index) => shadowCategoriesList[index],
  //     itemCount: shadowCategoriesList.length,
  //     separatorBuilder: (BuildContext context, int index) =>
  //         const SizedBox(height: kAppPaddingBetweenItemSmallSize),
  //   );
  // }

  // Widget _generateShadowSettingsCategoryItem() => Container(
  //     padding:
  //         const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
  //     child: const ShadowSettingsCategoryWidget());

  Widget _generateSettingsCategoriesList() {
    List<Widget> categoriesList = [
      _generateSettingsCategoryItem(Icons.person, "Account", "Account, Profile",
          () {
        Application.router.navigateTo(context, "/botp/settings/account");
      }, ColorType.primary),
      _generateSettingsCategoryItem(
          Icons.security, "Security", "Password, Biometrics, Sign-out", () {
        Application.router.navigateTo(context, "/botp/settings/security");
      }, ColorType.error),
      _generateSettingsCategoryItem(
          Icons.settings, "System", "Preferences, Notifications", () {
        Application.router.navigateTo(context, "/botp/settings/system");
      }, ColorType.secondary),
      _generateSettingsCategoryItem(
          Icons.info, "About", "Version, terms of services", () {
        Application.router.navigateTo(context, "/botp/settings/about");
      }, ColorType.tertiary),
    ];
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemSmallSize),
        itemCount: categoriesList.length,
        itemBuilder: (context, index) => categoriesList[index],
        // physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 0.0));
  }

  Widget _generateSettingsCategoryItem(IconData iconData, String title,
      String description, Function() onTap, ColorType colorType) {
    return Material(
        child: InkWell(
            onTap: onTap,
            child: SettingsCategoryWidget(
                iconData: iconData,
                title: title,
                description: description,
                colorType: colorType)));
  }
}
