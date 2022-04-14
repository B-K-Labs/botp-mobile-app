class OTPRequestModel {
  String message;
  int period;
  int digits;
  String algorithm;
  OTPRequestModel(this.message, this.period, this.digits, this.algorithm);
  Map<String, dynamic> toJson() => ({
        "message": message,
        "period": period,
        "digits": digits,
        "algorithm": algorithm
      });
}

class OTPResponseModel {
  String otp;
  int generatedTime;
  OTPResponseModel(this.otp, this.generatedTime);
  OTPResponseModel.fromJson(Map<String, dynamic> json)
      : otp = json["data"]["OTP"]["OTP"],
        generatedTime = json["data"]["OTP"]["timeGenerate"];
}
