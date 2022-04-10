// Store user preferences and other trivial data
// Singleton class: https://stackoverflow.com/questions/58389285/how-to-create-singleton-class-of-sharedpreferences-in-flutter
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefsInstance;

  // Local storage instance
  static Future<SharedPreferences> get _localStorage async {
    // Ensure it can retrieve the instance
    _prefsInstance ??= await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  // Basic methods
  static Future<Map<String, dynamic>?> getValue(String key) async {
    var localValue = (await _localStorage).getString(key);
    return localValue != null ? json.decode(localValue) : null;
  }

  static Future<bool> setValue(String key, Map<String, dynamic> value) async {
    return (await _localStorage).setString(key, json.encode(value));
  }

  static Future<bool> removeValue(String key) async {
    return (await _localStorage).remove(key);
  }

  // Additional methods
  static Future<Map<String, dynamic>> getAllValues() async {
    Set<String> localKeys = (await _localStorage).getKeys();
    Map<String, dynamic> returnMap = {};
    for (String key in localKeys) {
      returnMap[key] = json.decode((await _localStorage).getString(key)!);
    }
    return returnMap;
  }

  static Future<bool> removeAllValues() async {
    return (await _localStorage).clear();
  }
}
