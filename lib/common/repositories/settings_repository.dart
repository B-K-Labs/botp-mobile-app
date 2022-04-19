import 'package:botp_auth/common/models/settings_model.dart';
import 'package:botp_auth/configs/environment/environment.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;

class SettingsRepository {

  final apiUri = Environment().config

  Future<KYCResponseModel> kyc(String bcAddress, String fullName, int age,
      String gender, String debitor) async {
    final data =
        KYCRequestModel(bcAddress, fullName, age, gender, debitor).toJson();
    http.Response result = await post(BotpAPI.userKycUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return KYCResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception("Failed to do KYC");
  }
}
