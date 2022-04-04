// Store user credentials, API tokens, secret API keys
// More here: https://stackoverflow.com/questions/70014273/flutter-secure-storage-issues-unable-to-read-or-write-keys-and-values
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage? _securePrefsInstance;

  // Secure storage instance
  static get secureStorage {
    // Ensure it can retrieve the instance
    _securePrefsInstance ??= const FlutterSecureStorage();
    return _securePrefsInstance;
  }

  // Basic methods
  static Future<Map<String, dynamic>?> getSecureValue(String key) async {
    var secureLocalValue = secureStorage.read(key: key);
    return secureLocalValue != null ? json.decode(secureLocalValue) : null;
  }

  static Future<void> setSecureValue(
          String key, Map<String, dynamic> value) async =>
      secureStorage.write(key: key, value: json.encode(value));

  static Future<void> removeSecureValue(String key) async =>
      secureStorage.delete(key: key);

  // Additional methods
  static Future<Map<String, dynamic>> getAllSecureValues() async {
    Map<String, String> secureLocalMap = secureStorage.readAll();
    Map<String, dynamic> returnMap = {};
    secureLocalMap.entries
        .map((entry) => returnMap[entry.key] = json.decode(entry.value));
    return returnMap;
  }

  static Future<void> removeAllSecureValues() async =>
      secureStorage.deleteAll();
}
