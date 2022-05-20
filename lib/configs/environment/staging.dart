import 'package:botp_auth/configs/environment/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StagingConfig extends BaseConfig {
  @override
  String get baseApiUri => dotenv.env["MAIN_API_URL"]!;

  @override
  String get bcExplorerApiUri => dotenv.env["BC_EXPLORER_API_URL"]!;

  @override
  bool get freshAppData => false;
}
