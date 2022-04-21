class OTPSessionRequestModel {
  String message;
  int period;
  int digits;
  String algorithm;
  OTPSessionRequestModel(
      this.message, this.period, this.digits, this.algorithm);
  Map<String, dynamic> toJson() => ({
        "message": message,
        "period": period,
        "digits": digits,
        "algorithm": algorithm
      });
}

class OTPSessionResponseModel {
  String otp;
  int generatedTime;
  OTPSessionResponseModel(this.otp, this.generatedTime);
  OTPSessionResponseModel.fromJson(Map<String, dynamic> json)
      : otp = json["data"]["OTP"]["OTP"],
        generatedTime = json["data"]["OTP"]["timeGenerate"];
}
