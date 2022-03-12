// API endpoints

// Server
// 1. Development: replace by Wi-fi ip, which can be viewed in cmd > ipconfig
// 2. Production: your public url

class BotpAPI {
  static const _protocol = "http://";
  static const _server = "192.168.33.17";
  static const _port1 = "9000";
  static const _port2 = "9090";
  static const _basePath = "/api/v1";
  static const _urlRoot1 = "$_protocol$_server:$_port1$_basePath";
  static const _urlRoot2 = "$_protocol$_server:$_port2$_basePath";

  static const urlSignUp = "$_urlRoot1/signup";
  static const urlSignIn = "$_urlRoot1/import";
  static const urlReceiveOTP = "$_urlRoot1/otp/receive";
}
