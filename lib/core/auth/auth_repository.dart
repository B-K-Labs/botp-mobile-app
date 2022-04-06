import 'package:botp_auth/utils/tools/crypto.dart';
import 'package:universal_html/html.dart';
import 'package:botp_auth/core/auth/auth_model.dart';
import 'dart:convert';
import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;
// import 'package:crypto/crypto.dart';

class AuthRepository {
  // Sign up
  Future<SignUpResponseModel> signUp(String password) async {
    final data = SignUpRequestModel(password).toJSON();
    try {
      http.Response res = await post(BotpAPI.signUpUrl.toString(), data);
      if (res.statusCode == HttpStatus.ok) {
        return SignUpResponseModel.fromJson(json.decode(res.body));
      }
      throw Exception('Failed to sign up');
    } on Exception {
      rethrow;
    }
  }

  // Sign in
  Future<SignInResponseModel> signIn(String privateKey, String password) async {
    String hashedPrivateKey = hashSHA265(privateKey).toString();
    final data = SignInRequestModel(hashedPrivateKey, password)
        .toJSON(); // Hash the private key by SHA-256
    try {
      http.Response res = await post(BotpAPI.signInUrl.toString(), data);
      if (res.statusCode == HttpStatus.ok) {
        return SignInResponseModel.fromJson(json.decode(res.body));
      }
      throw Exception('Failed to sign in');
    } on Exception {
      rethrow;
    }
  }

  // Sign out
  Future<bool> signOut() async {
    return Future.value(true);
  }
}
