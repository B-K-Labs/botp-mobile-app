import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/modules/authentication/remiders/screens/biometric_setup_screen.dart';
import 'package:botp_auth/modules/authentication/remiders/screens/kyc_setup_screen.dart';
import 'package:botp_auth/modules/authentication/session/screens/session_screen.dart';
import 'package:botp_auth/modules/authentication/signin/screens/signin_screen.dart';
import 'package:botp_auth/modules/authentication/import/screens/import_screen.dart';
import 'package:botp_auth/modules/authentication/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/authentication/walkthroughs/screens/walkthrough_screen.dart';
import 'package:botp_auth/modules/authentication/init/screens/init_screen.dart';
import 'package:botp_auth/modules/botp/home/screens/botp_home_screen.dart';
import 'package:botp_auth/modules/botp/provenance/screens/provenance_screen.dart';
import 'package:botp_auth/modules/botp/settings/about/home/screens/about_home_screen.dart';
import 'package:botp_auth/modules/botp/settings/account/agent_setup/screens/agent_setup_screen.dart';
import 'package:botp_auth/modules/botp/settings/account/home/screens/account_home_screen.dart';
import 'package:botp_auth/modules/botp/settings/security/biometric_setup/screens/biometric_setup_screen.dart';
import 'package:botp_auth/modules/botp/settings/security/export_account/screens/export_account_screen.dart';
import 'package:botp_auth/modules/botp/settings/security/home/screens/security_home_screen.dart';
import 'package:botp_auth/modules/botp/settings/security/transfer_account/screens/transfer_account_screen.dart';
import 'package:botp_auth/modules/botp/settings/system/home/screens/system_home_screen.dart';
import 'package:botp_auth/modules/botp/transaction/screens/transaction_detail_screen.dart';
import 'package:botp_auth/modules/utils/qr_scanner/screens/qr_scanner.dart';
import 'package:botp_auth/modules/botp/settings/account/kyc_setup/screens/kyc_setup_screen.dart';
import 'package:botp_auth/modules/utils/webview/screens/webview_screen.dart';
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
  final fromScreen =
      context?.settings?.arguments as FromScreen? ?? FromScreen.auth;
  return ImportScreen(fromScreen: fromScreen);
});

// - Reminder KYC
var reminderKYCSetupHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const ReminderKYCSetupScreen();
});

// - Reminder Fingerprint
var reminderBiometricSetupHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const ReminderBiometricSetupScreen();
});

// 2. BOTP modules
// - BOTP Home
var botpHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const BOTPHomeScreen();
});

// - Transaction
var botpTransactionHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  final transactionDetail = context?.settings?.arguments as TransactionDetail;
  return TransactionDetailScreen(transactionDetail);
});

// - Provenance
var botpProvenanceHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  final provenanceInfo = context?.settings?.arguments as ProvenanceInfo;
  return ProvenanceScreen(provenanceInfo);
});

// - Settings
// - 1. Account
var botpSettingsAccountHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AccountHomeScreen();
});

var botpSettingsAccountSetupKYCHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  final fromScreen = context?.settings?.arguments as FromScreen? ??
      FromScreen.botpSettingsAccount;
  return AccountSetupKYCScreen(fromScreen: fromScreen);
});

var botpSettingsAccountAgentSetupHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AccountAgentSetupScreen();
});
// - 2. Security
var botpSettingsSecurityHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SecurityHomeScreen();
});

var botpSettingsSecurityTransferAccountHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SecurityTransferAccountScreen();
});

var botpSettingsSecurityExportAccountHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SecurityExportAccountScreen();
});

var botpSettingsSecuritySetupBiometricHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  final fromScreen = context?.settings?.arguments as FromScreen? ??
      FromScreen.botpSettingsSecurity;
  return SecurityBiometricSetupScreen(fromScreen: fromScreen);
});

// - 3. System
var botpSettingsSystemHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SystemHomeScreen();
});

// - 4. About
var botpSettingsAboutHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AboutHomeScreen();
});

// 3. Util modules
var qrScannerHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const QRScannerScreen();
});

var webViewHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  final url = context?.settings?.arguments as String;
  return WebViewScreen(url);
});
