import 'package:botp_auth/core/auth/models/auth_model.dart';
import 'dart:convert';
import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;
// import 'package:crypto/crypto.dart';

class AuthRepository {
  Future<SignUpResponseModel> signUp(String password) async {
    Map<String, dynamic> data = {
      'password': password,
    };
    http.Response res = await post(BotpAPI.signUpUrl, data);
    if (res.statusCode == 200) {
      return SignUpResponseModel.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to sign up');
  }

  Future<SignInResponseModel> signIn(String privateKey, String password) async {
    // Hash with SHA-265-1
    // var key = utf8.encode(password);
    // var bytes = utf8.encode(privateKey);
    // var hmacSha256 = Hmac(sha256, key);
    // var digest = hmacSha256.convert(bytes);

    Map<String, dynamic> data = {
      'hashedPrivateKey': privateKey,
      'password': password,
    };
    http.Response res = await post(BotpAPI.signInUrl, data);
    if (res.statusCode == 200) {
      return SignInResponseModel.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to sign in');
  }

  Future<bool> signOut() async {
    return Future.value(true);
  }
}
