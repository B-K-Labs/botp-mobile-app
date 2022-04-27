import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/authenticator/screens/authenticator_body.dart';
import 'package:botp_auth/modules/botp/history/screens/history_body.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_body.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";

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
    return ScreenWidget(
        // Appbar
        hasAppBar: _selectedIndex == 2 ? false : true,
        appBarType:
            _selectedIndex == 0 ? AppBarType.authenticator : AppBarType.history,
        // TODO: read user avatar
        appBarAvatarUrl: _selectedIndex == 0 ? null : null,
        appBarOnPressedAvatar: _selectedIndex == 0 ? null : null,
        // Body
        body: _getSelectedWidget(),
        // Bottom bar
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "History"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
          ],
          currentIndex: _selectedIndex,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
          onTap: _onItemTapped,
        ));
  }
}
