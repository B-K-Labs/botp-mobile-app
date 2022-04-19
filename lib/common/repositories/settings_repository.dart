import 'dart:convert';
import 'package:botp_auth/common/models/settings_model.dart';
import 'package:botp_auth/core/api_url/api_url.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class SettingsRepository {
  Future<KYCResponseModel> kyc(String bcAddress, String fullName, int age,
      String gender, String debitor) async {
    final data =
        KYCRequestModel(bcAddress, fullName, age, gender, debitor).toJson();
    http.Response result =
        await post(makeApiUrlString(path: "/author/KYC"), data);
    if (result.statusCode == HttpStatus.ok) {
      return KYCResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception("Failed to do KYC");
  }
}
