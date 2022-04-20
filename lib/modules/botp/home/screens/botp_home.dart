import 'package:botp_auth/modules/botp/authenticator/screens/authenticator_screen.dart';
import 'package:botp_auth/modules/botp/history/screens/history_home_screen.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_main_screen.dart';
import "package:flutter/material.dart";

class BOTPHomeScreen extends StatefulWidget {
  const BOTPHomeScreen({Key? key}) : super(key: key);

  @override
  State<BOTPHomeScreen> createState() => _BOTPHomeScreenState();
}

class _BOTPHomeScreenState extends State<BOTPHomeScreen> {
  int _selectedIndex = 0;
  // All home screens
  final Widget _authenticatorMainScreen = const AuthenticatorScreen();
  final Widget _historyMainScreen = const HistoryScreen();
  final Widget _settingsMainScreen = const SettingsHomeScreen();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedWidget() => _selectedIndex == 0
      ? _authenticatorMainScreen
      : _selectedIndex == 1
          ? _historyMainScreen
          : _settingsMainScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedWidget(),
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
      ),
    );
  }
}
