import 'package:botp_auth/modules/authentication/remiders/screens/kyc_setup_screen.dart';
import 'package:botp_auth/modules/authentication/session/screens/session_screen.dart';
import 'package:botp_auth/modules/authentication/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/authentication/import/screens/import_screen.dart';
import 'package:botp_auth/modules/authentication/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/authentication/walkthroughs/screens/walkthrough_screen.dart';
import 'package:botp_auth/modules/authentication/init/screens/init_screen.dart';
import 'package:botp_auth/modules/botp/home/screens/botp_home.dart';
import 'package:botp_auth/modules/botp/history/screens/history_home_screen.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_main_screen.dart';
import 'package:botp_auth/modules/utils/biometric_setup/screens/biometric_setup_screen.dart';
import 'package:botp_auth/modules/utils/qr_scanner/screens/qr_scanner.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// 1. Authentication modules
var authSessionHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SessionScreen();
});

// - WalkThrough
var authWalkThoughHandle =
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

// - Remider KYC
var reminderKYCSetupHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const ReminderKYCSetupScreen();
});

// - Remider Fingerprint
// TODO

// 2. BOTP modules
// - BOTP Home
var botpHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const BOTPHomeScreen();
});

// - Transaction
// TODO
var botpTransactionHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const Scaffold();
});

// // - Settings
// var botpSettingsHomeHandler =
//     Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//   return const SettingsHomeScreen();
// });

// 3. Util modules
var qrScannerHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const QRScannerScreen();
});

var biometricSetupHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const BiometricSetupScreen();
});
