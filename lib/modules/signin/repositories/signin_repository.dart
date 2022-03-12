import 'dart:convert';
import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/modules/signin/models/signin_model.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;

class SignInRepository {
  Future<SignInResponseModel> signIn(
      String password, String hashedPrivateKey) async {
    Map<String, dynamic> data = {
      'password': password,
      'hashedPrivateKey': hashedPrivateKey,
    };
    http.Response res = await post(BotpAPI.urlSignIn, data);
    if (res.statusCode == 200) {
      return SignInResponseModel.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to sign in');
  }
}
