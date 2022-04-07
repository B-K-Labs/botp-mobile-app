import 'package:botp_auth/utils/tools/crypto.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:botp_auth/core/authentication/auth_model.dart';
import 'package:botp_auth/constants/api_path.dart';
import 'dart:convert';
import 'package:universal_html/html.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  // Sign up
  Future<SignUpResponseModel> signUp(String password) async {
    final data = SignUpRequestModel(password).toJson();
    http.Response result = await post(BotpAPI.signUpUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return SignUpResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception('Failed to sign up');
  }

  // Sign in
  Future<SignInResponseModel> signIn(String address, String password) async {
    final data = SignInRequestModel(address, password).toJson();
    http.Response result = await post(BotpAPI.signInUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return SignInResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception('Failed to sign in');
  }

  // Import account
  Future<ImportResponseModel> importAccount(
      String privateKey, String password) async {
    String hashedPrivateKey = hashSHA265(privateKey).toString();
    final data = ImportRequestModel(hashedPrivateKey, password)
        .toJson(); // Hash the private key by SHA-256
    http.Response result = await post(BotpAPI.signInUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return ImportResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception('Failed to import account');
  }

  // Sign out
  Future<bool> signOut() async {
    return Future.value(true); // No need to request the server
  }
}
