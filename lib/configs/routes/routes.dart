import 'package:fluro/fluro.dart';
import 'package:botp_auth/configs/routes/routes_handler.dart';

class Routes {
  // >> Routes string
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
  static String authenticateTransaction = "/authenticator/:transaction_id";
  // + History
  static String history = "/history";
  // + Account
  static String account = "/account";

  // Routes configuration
  static void configureRoutes(FluroRouter router) {
    router.define(signInCurrent, handler: signInCurrentHandler);
    router.define(signInOther, handler: signInOtherHandler);
  }
}
