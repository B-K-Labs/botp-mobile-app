class SignInResponseModel {
  bool status;

  SignInResponseModel(this.status);
  SignInResponseModel.fromJson(Map<String, dynamic> json)
      : status = json['status'];
}
