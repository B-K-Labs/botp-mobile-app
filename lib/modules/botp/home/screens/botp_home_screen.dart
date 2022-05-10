import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/authenticator/screens/authenticator_body.dart';
import 'package:botp_auth/modules/botp/history/screens/history_body.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_body.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class BOTPHomeScreen extends StatefulWidget {
  const BOTPHomeScreen({Key? key}) : super(key: key);

  @override
  State<BOTPHomeScreen> createState() => _BOTPHomeScreenState();
}

class _BOTPHomeScreenState extends State<BOTPHomeScreen> {
  int _selectedIndex = 0;
  // All home screens
  final Widget _authenticatorMainBody = const AuthenticatorBody();
  final Widget _historyMainBody = const HistoryBody();
  final Widget _settingsMainBody = const SettingsBody();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedWidget() => _selectedIndex == 0
      ? _authenticatorMainBody
      : _selectedIndex == 1
          ? _historyMainBody
          : _settingsMainBody;

  @override
  Widget build(BuildContext context) {
    context.read<BOTPHomeCubit>().loadCommonUserData();
    return BlocConsumer<BOTPHomeCubit, BOTPHomeState>(
        listener: (context, state) {
          // Copy bc address
          final copyBcAddressStatus = state.copyBcAddressStatus;
          if (copyBcAddressStatus is SetClipboardStatusSuccess) {
            showSnackBar(
                context, "Blockchain address copied.", SnackBarType.success);
          } else if (copyBcAddressStatus is SetClipboardStatusFailed) {
            showSnackBar(context, copyBcAddressStatus.exception.toString());
          }
        },
        builder: (context, state) => ScreenWidget(
            // Appbar
            appBarElevation: 0,
            hasAppBar: _selectedIndex == 2 ? false : true,
            appBarType: _selectedIndex == 0
                ? AppBarType.authenticator
                : AppBarType.history,
            appBarAvatarUrl: _selectedIndex == 0 ? state.avatarUrl : null,
            appBarOnPressedAvatar: _selectedIndex == 0
                ? () {
                    _onItemTapped(2);
                  }
                : null,
            // Body
            body: _getSelectedWidget(),
            // Bottom bar
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "History"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "You"),
              ],
              currentIndex: _selectedIndex,
              selectedIconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
              onTap: _onItemTapped,
            )));
  }
}
