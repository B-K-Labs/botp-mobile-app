import 'dart:convert';

import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/core/settings/settings_model.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class SettingsRepository {
  Future<KYCResponseModel> kyc(String address, String fullName, int age,
      String gender, String debitor) async {
    final data =
        KYCRequestModel(address, fullName, age, gender, debitor).toJSON();
    http.Response result = await post(BotpAPI.userKycUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return KYCResponseModel.fromJSON(json.decode(result.body));
    }
    throw Exception("Failed to do KYC");
  }
}
