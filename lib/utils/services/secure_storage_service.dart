// User credentials, API tokens, secret API keys would be stored in Android Keystore using flutter_secure_storage plugins
// Note: https://stackoverflow.com/questions/70014273/flutter-secure-storage-issues-unable-to-read-or-write-keys-and-values
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  static late FlutterSecureStorage _securePrefsInstance;

  static init() {
    _securePrefsInstance = const FlutterSecureStorage();
  }

  // Basic methods
  static Future<Map<String, dynamic>> getMapValue(String key,
      [Map<String, dynamic> defaultValue = const {}]) async {
    var secureLocalValue = await _securePrefsInstance.read(key: key);
    return secureLocalValue != null
        ? json.decode(secureLocalValue)
        : defaultValue;
  }

  static Future<void> setMapValue(
          String key, Map<String, dynamic> value) async =>
      await _securePrefsInstance.write(key: key, value: json.encode(value));

  static Future<void> removeMapValue(String key) async =>
      await _securePrefsInstance.delete(key: key);

  // Additional methods
  static Future<Map<String, dynamic>> getAllMaps() async {
    Map<String, String> secureLocalMap = await _securePrefsInstance.readAll();
    Map<String, dynamic> returnMap = {};
    secureLocalMap.entries
        .map((entry) => returnMap[entry.key] = json.decode(entry.value));
    return returnMap;
  }

  static Future<void> removeAllMaps() async =>
      await _securePrefsInstance.deleteAll();
}
