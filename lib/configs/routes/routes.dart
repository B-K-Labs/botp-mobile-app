import 'package:fluro/fluro.dart';
import 'package:botp_auth/configs/routes/routes_handler.dart';

class Routes {
  // First-time use
  static String walkthrough = "/walkthrough/:page_id";
  static String welcome = "/welcome";
  // Sign in & sign up
  static String signInCurrent = "/signin/current";
  static String signInOther = "/signin/other";
  static String signUp = "/signup";
  // App
  // + Authenticator
  static String authenticator = "/authenticator";
  static String authenticateTransaction = "/authenticate/:transaction_id";
  // + History
  static String history = "/history";
  static String historyTransaction = "/history/:transaction_id";
  // + Account
  static String account = "/account";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;
    router.define(signUp, handler: signUpHandler);
    router.define(signInCurrent, handler: signInCurrentHandler);
    router.define(signInOther, handler: signInOtherHandler);
    router.define(signUp, handler: signUpHandler);
    router.define(authenticator, handler: authenticatorHandler);
  }
}
