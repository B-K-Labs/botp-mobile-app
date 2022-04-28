import 'package:botp_auth/configs/environment/environment.dart';

class ProductionConfig extends BaseConfig {
  @override
  String get baseApiUri =>
      // Wait for Hien <3
      "https://botp-backend-logic-api.herokuapp.com/api/v1";
  @override
  bool get freshAppData => false;
}
