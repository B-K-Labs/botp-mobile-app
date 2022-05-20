import 'package:botp_auth/configs/environment/environment.dart';

class ProductionConfig extends BaseConfig {
  @override
  String get baseApiUri =>
      "https://botp-backend-logic-api.herokuapp.com/api/v1";

  @override
  String get bcExplorerApiUri => "https://explorer.vbchain.vn/mbc/tx";

  @override
  bool get freshAppData => false;
}
