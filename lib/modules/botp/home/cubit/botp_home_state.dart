import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';

class BOTPHomeState {
  // Common user data
  String? avatarUrl;
  String? bcAddress;
  UserKYC? userKyc;
  // Reminder
  bool? didKyc;
  bool? needRegisterAgent;
  // Load data from storage status + server
  LoadUserDataStatus? loadUserDataStatus;
  RequestStatus? getAgentsListStatus;
  // Other
  SetClipboardStatus? copyBcAddressStatus;

  BOTPHomeState(
      {this.avatarUrl,
      this.bcAddress,
      this.userKyc,
      this.didKyc,
      this.needRegisterAgent,
      this.loadUserDataStatus = const LoadUserDataStatusInitial(),
      this.getAgentsListStatus = const RequestStatusInitial(),
      this.copyBcAddressStatus = const SetClipboardStatusInitial()});

  BOTPHomeState copyWith(
          {String? avatarUrl,
          String? bcAddress,
          UserKYC? userKyc,
          bool? didKyc,
          bool? needRegisterAgent,
          LoadUserDataStatus? loadUserDataStatus,
          RequestStatus? getAgentsListStatus,
          SetClipboardStatus? copyBcAddressStatus}) =>
      BOTPHomeState(
        avatarUrl: avatarUrl ?? this.avatarUrl,
        bcAddress: bcAddress ?? this.bcAddress,
        userKyc: userKyc ?? this.userKyc,
        didKyc: didKyc ?? this.didKyc,
        needRegisterAgent: needRegisterAgent ?? this.needRegisterAgent,
        loadUserDataStatus: loadUserDataStatus ?? this.loadUserDataStatus,
        getAgentsListStatus: getAgentsListStatus ?? this.getAgentsListStatus,
        copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus,
      );
}
