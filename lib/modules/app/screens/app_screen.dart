import 'package:botp_auth/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/modules/app/screens/account_body.dart';
import 'package:botp_auth/modules/app/screens/history_app.dart';
import 'package:botp_auth/modules/app/screens/authenticator_body.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;
  final Widget _authenticatorBody = const AuthenticatorBody();
  final Widget _historyBody = const HistoryBody();
  final Widget _accountBody = const AccountBody();

  @override
  Widget build(BuildContext context) {
    // Icon attribute
    const _selectedIconSize = 32.0, _unselectedIconSize = 24.0;

    return Scaffold(
        // appBar: AppBar(
        //     title: const Text("Home"),
        //     automaticallyImplyLeading: true,
        //     backgroundColor: AppColors.primaryColor,
        //     leading: IconButton(
        //         icon: const Icon(Icons.arrow_back),
        //         onPressed: () => Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (context) {
        //               return const SignUpScreen();
        //             })))),
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          // showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.grayColor04,
          selectedItemColor: AppColors.primaryColor,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: _unselectedIconSize),
              activeIcon: Icon(Icons.home, size: _selectedIconSize),
              label: "Authenticator",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: _unselectedIconSize),
              activeIcon: Icon(Icons.search, size: _selectedIconSize),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined, size: _unselectedIconSize),
              activeIcon: Icon(Icons.person, size: _selectedIconSize),
              label: "Account",
            ),
          ],
          onTap: (int index) => onTapHandler(index),
        ));
  }

  Widget getBody() {
    if (_currentIndex == 0) {
      return _authenticatorBody;
    } else if (_currentIndex == 1) {
      return _historyBody;
    } else {
      return _accountBody;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
