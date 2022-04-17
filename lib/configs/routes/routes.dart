import 'package:fluro/fluro.dart';
import 'package:botp_auth/configs/routes/routes_handler.dart';

class Routes {
  // Authentication modules
  static String session = "/";
  static String walkThrough = "/walkThrough";
  static String init = "/auth/init";
  static String signIn = "/auth/signIn";
  static String import = "/auth/import";
  static String signUp = "/auth/signUp";
  static String signOut = "/auth/signOut";
  static String reminderKYC = "/reminder/KYC";
  static String reminderFingerprint = "/reminder/fingerprint"; // TODO
  // Authenticator modules
  static String authenticatorHome = "/authenticator";
  // History modules
  static String historyHome = "/history";
  // Transaction modules
  static String transactionDetail = "/transactionDetail/:transactionDetail";
  // Settings modules
  static String settingsHome = "/settings";
  static String settingsAccount = "/settings/account";
  static String settingsAccountUpdateKYC =
      "/settings/account/updateKYC"; // TODO
  static String settingsSystem = "/settings/system";
  static String settingsSecurity = "/settings/security";
  static String settingsAbout = "/settings/about";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    // Authentication modules
    router.define(session, handler: authSessionHandler);
    router.define(walkThrough, handler: walkThoughtHandle);
    router.define(init, handler: authInitHandle);
    router.define(signUp, handler: authSignUpHandler);
    router.define(signIn, handler: authSignInHandler);
    router.define(import, handler: authImportHandler);
    // Authenticator modules
    router.define(authenticatorHome, handler: authenticatorHomeHandler);
    // History modules
    router.define(historyHome, handler: historyHomeHandler);
    // Transaction modules
    router.define(transactionDetail, handler: transactionDetailHandler);
    // Settings modules
    router.define(settingsHome, handler: settingsHomeHandler);
  }
}
