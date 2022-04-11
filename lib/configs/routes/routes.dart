import 'package:fluro/fluro.dart';
import 'package:botp_auth/configs/routes/routes_handler.dart';

class Routes {
  // Authentication modules
  static String session = "/";
  static String walkThrough = "/walkthroughs/:page_id";
  static String welcome = "/welcome";
  static String signInCurrent = "/signin/current";
  static String signInOther = "/signin/other";
  static String signUp = "/signup";
  // Authenticator modules
  static String authenticatorHome = "/authenticator";
  static String authenticateTransaction = "/authenticate/:transaction_id";
  // History modules
  static String historyHome = "/history";
  static String historyTransaction = "/history/:transaction_id";
  // Settings modules
  static String settingsHome = "/settings";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    // Authentication modules
    router.define(session, handler: sessionHandler);
    router.define(signUp, handler: signUpHandler);
    router.define(signInCurrent, handler: signInCurrentHandler);
    router.define(signInOther, handler: signInOtherHandler);
    // Authenticator modules
    router.define(authenticatorHome, handler: authenticatorHomeHandler);
    // History modules
    // TODO
    // Settings modules
    router.define(settingsHome, handler: settingsHomeHandler);
  }
}
