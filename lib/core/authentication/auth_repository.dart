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
      return SignUpResponseModel.fromJson(json.decode(result.body)["data"]);
    }
    throw Exception('Failed to sign up');
  }

  // Sign in
  Future<SignInResponseModel> signIn(String privateKey, String password) async {
    final hashedPrivateKey = hashSHA265(privateKey).toString();
    final data = SignInRequestModel(hashedPrivateKey, password).toJson();
    http.Response result = await post(BotpAPI.signInUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return SignInResponseModel.fromJson(json.decode(result.body)["data"]);
    }
    throw Exception(result.body);
    throw Exception('Failed to sign in');
  }

  // Import
  Future<ImportResponseModel> import(
      String privateKey, String newPassword) async {
    final data = ImportRequestModel(privateKey, newPassword).toJson();
    http.Response result = await post(BotpAPI.importUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return ImportResponseModel.fromJson(json.decode(result.body)["data"]);
    }
    throw Exception(result.body);
    throw Exception('Failed to sign in');
  }

  // Sign out
  Future<bool> signOut() async {
    return Future.value(true); // No need to request the server
  }
}
