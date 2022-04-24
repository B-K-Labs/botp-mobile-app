import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/modules/botp/authenticator/screens/authenticator_body.dart';
import 'package:botp_auth/modules/botp/history/screens/history_body.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_body.dart';
import 'package:botp_auth/widgets/bars.dart';
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
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBarWidget.generate(context,
              type: AppBarType.authenticator,
              title: "BOTP Authenticator",
              // TODO: read user avatar
              avatarUrl:
                  "https://i.pinimg.com/originals/9b/cd/dc/9bcddc6f49de22125e2494591e250096.png",
              onPressedAvatar: () {})
          : _selectedIndex == 1
              ? AppBarWidget.generate(context,
                  type: AppBarType.history, title: "Provenance")
              : null,
      body: SafeArea(bottom: true, child: _getSelectedWidget()),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Provenance"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
        ],
        currentIndex: _selectedIndex,
        selectedIconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.primary),
        onTap: _onItemTapped,
      ),
    );
  }
}
