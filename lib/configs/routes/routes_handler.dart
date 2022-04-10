import 'package:botp_auth/core/authentication/app_navigator.dart';
import 'package:botp_auth/modules/authentication/signin_current/screens/signin_current_screen.dart';
import 'package:botp_auth/modules/authentication/signin_other/screens/signin_other_screen.dart';
import 'package:botp_auth/modules/authentication/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/botp/authenticator/screens/authenticator_main_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// App entry
// - App navigator
var appNavigatorHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AppNavigator();
});

// Auth modules
// - Walkthrough
// TODO

// - Sign up
var signUpHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignUpScreen();
});

// - Sign In (current account)
var signInCurrentHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInCurrentScreen();
});

// - Sign in (other account)
var signInOtherHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInOtherScreen();
});

// Main modules
// - Authenticator
var authenticatorHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AuthenticatorMainScreen();
});

// - History
// TODO
// var historyHandler =
//     Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//   return const MainAppScreen();
// });

// - Settings
// TODO
// var settingsHandler =
//     Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//   return const MainAppScreen();
// });
