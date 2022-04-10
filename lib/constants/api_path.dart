// API endpoints

// Server
// 1. Development: replace by Wi-fi ip, which can be viewed in cmd > ipconfig
// 2. Production: your public url

class BotpAPI {
  static const _protocol = "https";
  static const _host =
      "botp-backend-logic-api.herokuapp.com"; // botp-main.herokuapp.com
  static const _basePath = "/api/v1";

  static var signUpUrl = Uri(
      scheme: _protocol, host: _host, path: '$_basePath/authen/createAccount');
  static var importUrl = Uri(
      scheme: _protocol, host: _host, path: '$_basePath/authen/importAccount');
  static var signInUrl =
      Uri(scheme: _protocol, host: _host, path: '$_basePath/authen/signIn');
  // static var userKycUrl =
  //     Uri(scheme: _protocol, host: _host, path: '$_basePath/user/doKYC');
  // static var receiveOtpUrl =
  //     Uri(scheme: _protocol, host: _host, path: '$_basePath/otp/receive');
}
