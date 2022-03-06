import 'dart:convert';

import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/modules/signup/models/signup_model.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;

class SignUpRepository {
  static Future<SignUpResponseModel> signUp(String password) async {
    Map<String, dynamic> data = {
      'password': password,
    };
    http.Response res = await post(urlSignUp, data);
    if (res.statusCode == 200) {
      return SignUpResponseModel.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to sign up');
  }
}
