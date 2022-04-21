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
  static String reminderKYC = "/auth/reminder/kyc";
  // static String reminderFingerprint = "/auth/reminder/fingerprint"; // TODO
  // 2. BOTP modules
  static String home = "/botp";
  static String transaction = "/botp/transaction";
  static String settingsAccount = "/botp/settings/account";
  static String settingsAccountSetupKYC = "/botp/settings/account/setupKyc";
  static String settingsSystem = "/botp/settings/system";
  static String settingsSecurity = "/botp/settings/security";
  static String settingsAbout = "/botp/settings/about";
  // 3. Utils modules
  static String qrScanner = "/utils/qrScanner";
  static String biometricSetup = "/utils/biometricSetup";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    // 1. Authentication modules
    router.define(authSession,
        handler: authSessionHandler, transitionType: TransitionType.fadeIn);
    router.define(walkThrough,
        handler: authWalkThoughHandle, transitionType: TransitionType.fadeIn);
    router.define(init,
        handler: authInitHandle, transitionType: TransitionType.fadeIn);
    router.define(signUp,
        handler: authSignUpHandler, transitionType: TransitionType.fadeIn);
    router.define(signIn,
        handler: authSignInHandler, transitionType: TransitionType.fadeIn);
    router.define(import,
        handler: authImportHandler, transitionType: TransitionType.fadeIn);
    router.define(reminderKYC,
        handler: reminderKYCSetupHandler,
        transitionType: TransitionType.fadeIn);
    // 2. BOTP modules
    router.define(home,
        handler: botpHomeHandler, transitionType: TransitionType.fadeIn);
    router.define(transaction,
        handler: botpTransactionHandler, transitionType: TransitionType.fadeIn);
    router.define(settingsAccount,
        handler: botpSettingsAccountHandler,
        transitionType: TransitionType.fadeIn);
    router.define(settingsAccountSetupKYC,
        handler: botpSettingsAccountUpdateKYCHandler,
        transitionType: TransitionType.fadeIn);
    // 3. Utils modules
    router.define(qrScanner,
        handler: qrScannerHandler, transitionType: TransitionType.fadeIn);
    router.define(biometricSetup,
        handler: biometricSetupHandler, transitionType: TransitionType.fadeIn);
  }
}
