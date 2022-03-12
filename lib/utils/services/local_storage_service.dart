// Store and get data from the local storage using shared_preferences plugins
// Singleton class: https://stackoverflow.com/questions/58389285/how-to-create-singleton-class-of-sharedpreferences-in-flutter
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils {
  static late SharedPreferences _prefsInstance;

  // Initializing function: call from initState() function of mainApp()
  static init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  // Basic methods
  static getMapValue(String key,
      [Map<String, dynamic> defaultValue = const {}]) async {
    var localValue = _prefsInstance.getString(key);
    return localValue != null ? json.decode(localValue) : defaultValue;
  }

  static Future<bool> setMapValue(
          String key, Map<String, dynamic> value) async =>
      await _prefsInstance.setString(key, json.encode(value));

  static Future<bool> removeMapValue(String key) async =>
      await _prefsInstance.remove(key);

  // Additional methods
  static bool containKey(String key) => _prefsInstance.containsKey(key);
}
