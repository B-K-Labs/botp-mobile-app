import 'package:botp_auth/configs/environment/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DevelopmentConfig extends BaseConfig {
  @override
  String get baseApiUri =>
      dotenv.env["API_URL"] ?? "http://localhost:8000/api/v1";
  @override
  bool get freshAppData => true;
}
