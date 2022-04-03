import 'dart:convert';
import 'package:crypto/crypto.dart';

Digest hashSHA265(message) {
  var bytes = utf8.encode(message);
  var digest = sha256.convert(bytes);
  return digest;
}
