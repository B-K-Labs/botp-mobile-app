import 'package:botp_auth/core/auth/initial/screens/app_navigator.dart';
import 'package:botp_auth/core/auth/signin/screens/signin_current_screen.dart';
import 'package:botp_auth/core/auth/signin/screens/signin_other_screen.dart';
import 'package:botp_auth/core/auth/signup/screens/signup_screen.dart';
import 'package:botp_auth/modules/app/screens/app_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// App navigator
var appNavigatorHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const AppNavigator();
});

// Sign up
var signUpHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignUpScreen();
});

// Sign In (current account)
var signInCurrentHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInCurrentScreen();
});

// Sign in (other account)
var signInOtherHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SignInOtherScreen();
});

var authenticatorHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const MainAppScreen();
});
