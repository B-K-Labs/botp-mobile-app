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
  static String settingsAccountAgentSetup = "/botp/settings/account/agentSetup";
  static String settingsAccountAgentInfo = "/botp/settings/account/agentInfo";
  static String settingsSecurity = "/botp/settings/security";
  static String settingsSecurityTransferAccount =
      "/botp/settings/security/transfer";
  static String settingsSecurityExportAccount =
      "/botp/settings/security/transfer/export";
  static String settingsSystem = "/botp/settings/system";
  static String settingsAbout = "/botp/settings/about";
  // 3. Utils modules
  static String qrScanner = "/utils/qrScanner";
  static String biometricSetup = "/utils/biometricSetup";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    // 1. Authentication modules
    router.define(authSession,
        handler: authSessionHandler,
        transitionType: TransitionType.inFromRight);
    router.define(walkThrough,
        handler: authWalkThoughHandle,
        transitionType: TransitionType.inFromRight);
    router.define(init,
        handler: authInitHandle, transitionType: TransitionType.inFromRight);
    router.define(signUp,
        handler: authSignUpHandler, transitionType: TransitionType.inFromRight);
    router.define(signIn,
        handler: authSignInHandler, transitionType: TransitionType.inFromRight);
    router.define(import,
        handler: authImportHandler, transitionType: TransitionType.inFromRight);
    router.define(reminderKYC,
        handler: reminderKYCSetupHandler,
        transitionType: TransitionType.inFromRight);
    // 2. BOTP modules
    router.define(home,
        handler: botpHomeHandler, transitionType: TransitionType.inFromRight);
    router.define(transaction,
        handler: botpTransactionHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsAccount,
        handler: botpSettingsAccountHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsAccountSetupKYC,
        handler: botpSettingsAccountSetupKYCHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsAccountAgentSetup,
        handler: botpSettingsAccountAgentSetupHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsAccountAgentInfo,
        handler: botpSettingsAccountAgentInfoHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsSecurity,
        handler: botpSettingsSecurityHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsSecurityTransferAccount,
        handler: botpSettingsSecurityTransferAccountHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsSecurityExportAccount,
        handler: botpSettingsSecurityExportAccountHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsSystem,
        handler: botpSettingsSystemHandler,
        transitionType: TransitionType.inFromRight);
    router.define(settingsAbout,
        handler: botpSettingsAboutHandler,
        transitionType: TransitionType.inFromRight);
    // 3. Utils modules
    router.define(qrScanner,
        handler: qrScannerHandler, transitionType: TransitionType.inFromRight);
    router.define(biometricSetup,
        handler: biometricSetupHandler,
        transitionType: TransitionType.inFromRight);
  }
}
