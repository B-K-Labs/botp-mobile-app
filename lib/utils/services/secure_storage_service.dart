// Store user credentials, API tokens, secret API keys
// More here: https://stackoverflow.com/questions/70014273/flutter-secure-storage-issues-unable-to-read-or-write-keys-and-values
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _securePrefsInstance =
      FlutterSecureStorage();

  // Secure storage instance
  static FlutterSecureStorage get secureStorage => _securePrefsInstance;

  // Basic methods
  static Future<Map<String, dynamic>?> getSecureValue(String key) async {
    var secureLocalValue = await secureStorage.read(key: key);
    return secureLocalValue != null ? json.decode(secureLocalValue) : null;
  }

  static Future<void> setSecureValue(
          String key, Map<String, dynamic> value) async =>
      await secureStorage.write(key: key, value: json.encode(value));

  static Future<void> removeSecureValue(String key) async =>
      await secureStorage.delete(key: key);

  // Additional methods
  static Future<Map<String, dynamic>> getAllSecureValues() async {
    Map<String, String> secureLocalMap = await secureStorage.readAll();
    Map<String, dynamic> returnMap = {};
    // Decode all map values
    secureLocalMap.entries
        .map((entry) => returnMap[entry.key] = json.decode(entry.value));
    return returnMap;
  }

  static Future<void> removeAllSecureValues() async =>
      await secureStorage.deleteAll();
}
