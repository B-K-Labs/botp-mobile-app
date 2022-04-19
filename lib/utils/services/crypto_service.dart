import 'dart:convert';
import 'package:crypto/crypto.dart';
import "package:otp/otp.dart";
import 'package:base32/base32.dart';

// For hashing privateKey
Digest hashSHA265(message) {
  var bytes = utf8.encode(message);
  var digest = sha256.convert(bytes);
  return digest;
}

Map<String, dynamic> mapAlgorithm = {
  "SHA-1": Algorithm.SHA1,
  "SHA-256": Algorithm.SHA256,
  "SHA-512": Algorithm.SHA512,
};

// For generate TOTP from key message
String generateTOTP(
    String message, int digits, int period, int timestamp, String algorithm) {
  // print('Dart input: $message $digits $period $timestamp $algorithm');
  final messageBase64 = base32.encodeString(message);
  // Generate OTP
  final otp = OTP.generateTOTPCodeString(messageBase64, timestamp,
      length: digits,
      interval: period,
      algorithm: mapAlgorithm[algorithm],
      isGoogle:
          true); // Important: turn on secret padding for Google Authenticator
  // print('Dart OTP: $otp');
  return otp;
}
