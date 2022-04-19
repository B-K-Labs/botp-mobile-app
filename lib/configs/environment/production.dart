import 'package:botp_auth/configs/environment/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductionConfig extends BaseConfig {
  @override
  Uri get apiUri => Uri.parse(
      "https://botp-backend-logic-api.herokuapp.com/api/v1"); // Wait for Hien <3
}
