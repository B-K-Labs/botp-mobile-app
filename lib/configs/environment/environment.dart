import 'package:botp_auth/configs/environment/development.dart';
import 'package:botp_auth/configs/environment/production.dart';
import 'package:botp_auth/configs/environment/staging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // Singleton pattern
  factory Environment() {
    return _singleton;
  }
  static final Environment _singleton = Environment._internal();

  Environment._internal();

  // Constants
  static const String kDevelopment = 'DEV';
  static const String kStaging = 'STAG';
  static const String kProduction = 'PROD';
  static const String kFlutterEnv = 'FLUTTER_APP_ENV';

  // Set base config
  late BaseConfig config;

  // Your configuration entry here
  initConfig() async {
    await dotenv.load(); // Load once, use config object everywhere
    config = _getConfig(dotenv.env[kFlutterEnv]);
  }

  BaseConfig _getConfig(String? flutterEnv) {
    switch (flutterEnv) {
      case kStaging:
        return StagingConfig();
      case kDevelopment:
        return DevelopmentConfig();
      case kProduction:
      default:
        return ProductionConfig();
    }
  }
}

abstract class BaseConfig {
  String get mainApiUri;
  String get bcExplorerApiUri;
  bool get freshAppData;
}
