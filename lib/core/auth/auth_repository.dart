import 'package:botp_auth/utils/tools/crypto.dart';
import 'package:universal_html/html.dart';
import 'package:botp_auth/core/auth/auth_model.dart';
import 'dart:convert';
import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  // Sign up
  Future<SignUpResponseModel> signUp(String password) async {
    final data = SignUpRequestModel(password).toJSON();
    http.Response result = await post(BotpAPI.signUpUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return SignUpResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception('Failed to sign up');
  }

  // Sign in
  Future<SignInResponseModel> signIn(String privateKey, String password) async {
    String hashedPrivateKey = hashSHA265(privateKey).toString();
    final data = SignInRequestModel(hashedPrivateKey, password)
        .toJSON(); // Hash the private key by SHA-256
    http.Response result = await post(BotpAPI.signInUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return SignInResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception('Failed to sign in');
  }

  // Import account

  // Sign out
  Future<bool> signOut() async {
    return Future.value(true);
  }
}
