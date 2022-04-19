import 'package:botp_auth/configs/environment/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StagingConfig extends BaseConfig {
  @override
  Uri get apiUri => Uri.parse(dotenv.env["API_URL"]!);
}
