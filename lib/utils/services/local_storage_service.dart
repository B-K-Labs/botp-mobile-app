// Store and get data from the local storage using shared_preferences plugins
// Singleton class: https://stackoverflow.com/questions/58389285/how-to-create-singleton-class-of-sharedpreferences-in-flutter
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefsInstance;

  static get storage async => _prefsInstance;

  // (?) Initializing function: call from initState() function of mainApp()
  static init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  // Basic methods
  static Future<Map<String, dynamic>?> getValue(String key) async {
    await init();
    var localValue = _prefsInstance.getString(key);
    return localValue != null ? json.decode(localValue) : null;
  }

  static Future<bool> setValue(String key, Map<String, dynamic> value) async {
    await init();
    return await _prefsInstance.setString(key, json.encode(value));
  }

  static Future<bool> removeValue(String key) async {
    await init();
    return await _prefsInstance.remove(key);
  }

  // Additional methods
  static Future<Map<String, dynamic>> getAllValues() async {
    Set<String> localKeys = _prefsInstance.getKeys();
    Map<String, dynamic> returnMap = {};
    for (String key in localKeys) {
      returnMap[key] = json.decode(_prefsInstance.getString(key)!);
    }
    return returnMap;
  }

  static Future<bool> removeAllValues() async {
    await init();
    return await _prefsInstance.clear();
  }
}
