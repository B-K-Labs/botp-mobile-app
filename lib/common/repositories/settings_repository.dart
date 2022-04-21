import 'dart:convert';
import 'package:botp_auth/common/models/settings_model.dart';
import 'package:botp_auth/core/api_url/api_url.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class SettingsRepository {
  // Update KYC
  Future<KYCResponseModel> updateKyc(
      String bcAddress,
      String password,
      String fullName,
      String address,
      int age,
      String gender,
      String debitor) async {
    final data = KYCRequestModel(
            bcAddress, password, fullName, address, age, gender, debitor)
        .toJson();
    http.Response result =
        await post(makeApiUrlString(path: "/author/KYC"), data);
    if (result.statusCode == HttpStatus.ok) {
      return KYCResponseModel.fromJSON(json.decode(result.body));
    }
    throw Exception(result.body);
  }
}
