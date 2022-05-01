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
      try {
        return KYCResponseModel.fromJSON(json.decode(result.body));
      } on Exception catch (_) {
        throw Exception(json.decode(result.body));
      }
    }
    throw Exception(result.body);
  }

  // Update Avatar
  // TODO

  // Send Agent from QR
  Future<SetupAgentResponseModel> setUpAgent(
      String setupAgentUrl, String userBcAddress) async {
    final data = SetupAgentRequestModel(setupAgentUrl, userBcAddress).toJSON();
    http.Response result =
        await post(makeApiUrlString(path: "/QRcode/processQRInfo"), data);
    if (result.statusCode == HttpStatus.ok) {
      return SetupAgentResponseModel.fromJSON(json.decode(result.body));
    }
    throw Exception(result.body);
  }

  // Get Agents list
  Future<GetAgentsListResponseModel> getAgentsList(String bcAddress) async {
    final queryParameters = {"userAddr": bcAddress};
    http.Response result = await get(makeApiUrlString(
        path: '/QRcode/getAgentList', queryParameters: queryParameters));
    if (result.statusCode == HttpStatus.ok) {
      final agentsList = json.decode(result.body) as List<dynamic>;
      return agentsList.isEmpty
          ? GetAgentsListResponseModel([])
          : GetAgentsListResponseModel.fromJSON(
              agentsList[0] as Map<String, dynamic>);
    }
    throw Exception(result.body);
  }
}
