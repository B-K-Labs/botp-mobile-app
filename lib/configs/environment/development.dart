import 'package:botp_auth/configs/environment/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DevelopmentConfig extends BaseConfig {
  @override
  String get mainApiUri =>
      dotenv.env["MAIN_API_URL"] ?? "http://localhost:8000/api/v1";

  @override
  String get bcExplorerApiUri =>
      dotenv.env["BC_EXPLORER_API_URL"] ?? "http://localhost:8000/api/v1";

  @override
  bool get freshAppData => true;
}
