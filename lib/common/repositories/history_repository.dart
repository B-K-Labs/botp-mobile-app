import 'dart:convert';

import 'package:botp_auth/common/models/history_model.dart';
import 'package:botp_auth/constants/api_path.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:universal_html/html.dart';

class HistoryRepository {
  final algorithm = "SHA-512";

  Future<OTPResponseModel> generateOtp(
      String message, int period, int digits) async {
    final data = OTPRequestModel(message, period, digits, algorithm);
    final result = await post(BotpAPI.generateOtpUrl.toString(), data);
    if (result.statusCode == HttpStatus.ok) {
      return OTPResponseModel.fromJson(json.decode(result.body));
    }
    throw Exception('Failed to generate OTP');
  }
}
