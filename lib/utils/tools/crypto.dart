import 'dart:convert';
import 'package:crypto/crypto.dart';

Digest hashSHA265(message, password) {
  // Encode to utf8
  var key = utf8.encode(password);
  var bytes = utf8.encode(message);
  // Digest message with key
  var hmacSha256 = Hmac(sha256, key);
  var digest = hmacSha256.convert(bytes);
  return digest;
}
