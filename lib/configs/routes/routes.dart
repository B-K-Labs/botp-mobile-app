import 'package:fluro/fluro.dart';
import 'package:botp_auth/configs/routes/routes_handler.dart';

class Routes {
  // 1. Authentication modules
  static String session = "/";
  static String walkThrough = "/walkThrough";
  static String init = "/auth/init";
  static String signIn = "/auth/signIn";
  static String import = "/auth/import";
  static String signUp = "/auth/signUp";
  static String signOut = "/auth/signOut";
  static String reminderKYC = "/reminder/KYC";
  static String reminderFingerprint = "/reminder/fingerprint"; // TODO
  // 2. BOTP modules
  static String authenticator = "/authenticator";
  static String history = "/history";
  static String transaction = "/transactionDetail/:transactionDetail";
  // 3. Settings modules
  static String settingsHome = "/settings";
  static String settingsAccount = "/settings/account";
  static String settingsAccountUpdateKYC =
      "/settings/account/updateKYC"; // TODO
  static String settingsSystem = "/settings/system";
  static String settingsSecurity = "/settings/security";
  static String settingsAbout = "/settings/about";
  // 4. Other modules
  static String qrScanner = "utils/qrScanner";
  static String biometricSetup = "utils/biometricSetup";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    // 1. Authentication modules
    router.define(session, handler: authSessionHandler);
    router.define(walkThrough, handler: walkThoughtHandle);
    router.define(init, handler: authInitHandle);
    router.define(signUp, handler: authSignUpHandler);
    router.define(signIn, handler: authSignInHandler);
    router.define(import, handler: authImportHandler);
    // 2. BOTP modules
    router.define(authenticator, handler: authenticatorHomeHandler);
    router.define(history, handler: historyHomeHandler);
    router.define(transaction, handler: transactionHandler);
    // 3. Settings modules
    router.define(settingsHome, handler: settingsHomeHandler);
    // 4. Other modules
    router.define(qrScanner, handler: qrScannerHandler);
    router.define(biometricSetup, handler: biometricSetupHandler);
  }
}
