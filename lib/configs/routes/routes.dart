import 'package:fluro/fluro.dart';
import 'package:botp_auth/configs/routes/routes_handler.dart';

class Routes {
  // 1. Authentication modules
  static String authSession = "/";
  static String walkThrough = "/auth/walkThrough";
  static String init = "/auth/init";
  static String signIn = "/auth/signIn";
  static String import = "/auth/import";
  static String signUp = "/auth/signUp";
  static String signOut = "/auth/signOut";
  static String reminderKYC = "/auth/reminder/KYC";
  // static String reminderFingerprint = "/auth/reminder/fingerprint"; // TODO
  // 2. BOTP modules
  static String botpHome = "/botp";
  // static String authenticator = "/botp/authenticator";
  // static String history = "/botp/history";
  static String transaction = "/botp/transactionDetail/:transactionDetail";
  // static String settingsHome = "/botp/settings";
  static String settingsAccount = "/botp/settings/account";
  static String settingsAccountUpdateKYC =
      "/botp/settings/account/updateKYC"; // TODO
  static String settingsSystem = "/botp/settings/system";
  static String settingsSecurity = "/botp/settings/security";
  static String settingsAbout = "/botp/settings/about";
  // 4. Utils modules
  static String qrScanner = "/utils/qrScanner";
  static String biometricSetup = "/utils/biometricSetup";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    // 1. Authentication modules
    router.define(authSession, handler: authSessionHandler);
    router.define(walkThrough, handler: authWalkThoughHandle);
    router.define(init, handler: authInitHandle);
    router.define(signUp, handler: authSignUpHandler);
    router.define(signIn, handler: authSignInHandler);
    router.define(import, handler: authImportHandler);
    router.define(reminderKYC, handler: reminderKYCSetupHandler);
    // 2. BOTP modules
    router.define(botpHome, handler: botpHomeHandler);
    router.define(transaction, handler: botpTransactionHandler);
    router.define(settingsAccount, handler: botpSettingsAccountHandler);
    // 3. Utils modules
    router.define(qrScanner, handler: qrScannerHandler);
    router.define(biometricSetup, handler: biometricSetupHandler);
  }
}
