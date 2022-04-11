import 'package:botp_auth/modules/authentication/session/screens/session_screen.dart';
import 'package:botp_auth/modules/authentication/signin_current/screens/signin_current_screen.dart';
import 'package:botp_auth/modules/authentication/signin_other/screens/signin_other_screen.dart';
import 'package:botp_auth/modules/authentication/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/botp/authenticator/home/screens/authenticator_main_screen.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_main_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// Auth modules
// - Walkthrough
// TODO

// - Session
var sessionHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SessionScreen();
});

// - Sign up
var signUpHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignUpScreen();
});

// - Sign in (current account)
var signInCurrentHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInCurrentScreen();
});

// - Sign in (other account)
var signInOtherHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInOtherScreen();
});

// Authenticator modules
// + Home
var authenticatorHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AuthenticatorHomeScreen();
});

// + Authenticate transaction
// TODO

// History modules
// TODO

// Settings modules
var settingsHomeHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SettingsHomeScreen();
});
