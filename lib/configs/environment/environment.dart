class Environment {
  factory Environment() {
    return _singleton;
  }
  static final Environment _singleton = Environment._internal();

  Environment._internal();

  static const String dev = 'DEV';
  static const String staging = 'STAGING';
  static const String prod = 'PROD';

  BaseConfig config;
}

abstract class BaseConfig {}
