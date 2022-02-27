import 'package:botp_auth/constants/app_constants.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
  int currentIndex = 0;
  final Widget _homeBody = const HomeBody();
  final Widget _historyBody = const HistoryBody();
  final Widget _accountBody = const AccountBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: const Text("Home"),
        //     automaticallyImplyLeading: true,
        //     backgroundColor: kPrimaryColor,
        //     leading: IconButton(
        //       icon: const Icon(Icons.arrow_back),
        //       onPressed: () => Navigator.pop(context, false),
        //     )),
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.home, size: 32.0),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 32.0),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 32.0),
              label: "Account",
            ),
          ],
          onTap: (int index) => onTapHandler(index),
        ));
  }

  Widget getBody() {
    if (currentIndex == 0) {
      return _homeBody;
    } else if (currentIndex == 1) {
      return _historyBody;
    } else {
      return _accountBody;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
