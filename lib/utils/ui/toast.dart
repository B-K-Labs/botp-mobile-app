import 'package:flutter/material.dart';

void showSnackBar(context, message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
