import 'package:botp_auth/modules/authentication/session/screens/session_screen.dart';
import 'package:botp_auth/modules/authentication/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/authentication/import/screens/import_screen.dart';
import 'package:botp_auth/modules/authentication/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/authentication/walkthroughs/screens/walkthrough_screen.dart';
import 'package:botp_auth/modules/authentication/init/screens/init_screen.dart';
import 'package:botp_auth/modules/botp/authenticator/screens/botp_home.dart';
import 'package:botp_auth/modules/botp/history/screens/history_home_screen.dart';
import 'package:botp_auth/modules/settings/home/screens/settings_main_screen.dart';
import 'package:botp_auth/modules/utils/biometric_setup/screens/biometric_setup_screen.dart';
import 'package:botp_auth/modules/utils/qr_scanner/screens/qr_scanner.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// 1. Auth modules
// - Session
var authSessionHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SessionScreen();
});

// - WalkThrough
var walkThoughtHandle =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const WalkThroughScreen();
});

// - Welcome
var authInitHandle =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const InitScreen();
});

// - Sign up
var authSignUpHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignUpScreen();
});

// - Sign in
var authSignInHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInScreen();
});

// - Import
var authImportHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const ImportScreen();
});

// 2. BOTP modules
// - Authenticator
var authenticatorHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const BOTPHomeScreen();
});

// - History
var historyHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const HistoryScreen();
});

// - Transaction
// TODO
var transactionHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const Scaffold();
});

// 3. Settings modules
// - Home
var settingsHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SettingsHomeScreen();
});

// 4. Other modules
var qrScannerHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const QRScannerScreen();
});

var biometricSetupHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const BiometricSetupScreen();
});
