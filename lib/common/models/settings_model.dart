import 'package:botp_auth/common/models/common_model.dart';

class KYCRequestModel {
  final String bcAddress;
  final String password;
  final String fullName;
  final String address;
  final int age;
  final String gender;
  final String debitor;
  KYCRequestModel(this.bcAddress, this.password, this.fullName, this.address,
      this.age, this.gender, this.debitor);
  Map<String, dynamic> toJson() => ({
        "bcAddress": bcAddress,
        "password": password,
        "type": "USER",
        "info": {
          "fullName": fullName,
          "address": address,
          "age": age,
          "gender": gender,
          "debitor": debitor,
        }
      });
}

class KYCResponseModel {
  final Object info;
  KYCResponseModel(this.info);
  KYCResponseModel.fromJSON(Map<String, dynamic> json) : info = json["info"];
}

class SetupAgentRequestModel {
  final String setupAgentUrl;
  final String userBcAddress;

  SetupAgentRequestModel(this.setupAgentUrl, this.userBcAddress);
  Map<String, dynamic> toJSON() =>
      {"url": setupAgentUrl, "userAddr": userBcAddress};
}

class SetupAgentResponseModel {
  AgentInfo agentInfo;

  SetupAgentResponseModel(this.agentInfo);
  SetupAgentResponseModel.fromJSON(Map<String, dynamic> json)
      : agentInfo = AgentInfo(
            name: json["agentInfo"]["info"]["fullName"],
            description: json["agentInfo"]["info"]["description"],
            bcAddress: json["agentInfo"]["bcAddress"],
            avatarUrl: json["agentInfo"]["avatar"],
            isVerified: true);
}

class GetAgentsListResponseModel {
  List<String> agentBcAddressesList;

  GetAgentsListResponseModel(this.agentBcAddressesList);
  GetAgentsListResponseModel.fromJSON(Map<String, dynamic> json)
      : agentBcAddressesList = json["agentList"];
}
