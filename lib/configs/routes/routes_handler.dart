import 'package:botp_auth/modules/signin/screens/signin_other_screen.dart';
import 'package:botp_auth/modules/signin/screens/signin_current_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

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
