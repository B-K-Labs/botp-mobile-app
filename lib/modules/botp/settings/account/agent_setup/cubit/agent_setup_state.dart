import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';

class AccountAgentSetupState {
  final RequestStatus setupAgentStatus;
  final AgentInfo? agentInfo;
  final SetClipboardStatus? copyBcAddressStatus;

  AccountAgentSetupState(
      {this.setupAgentStatus = const RequestStatusInitial(),
      this.agentInfo,
      this.copyBcAddressStatus = const SetClipboardStatusInitial()});

  AccountAgentSetupState copyWith(
          {RequestStatus? setupAgentStatus,
          AgentInfo? agentInfo,
          SetClipboardStatus? copyBcAddressStatus}) =>
      AccountAgentSetupState(
          setupAgentStatus: setupAgentStatus ?? this.setupAgentStatus,
          agentInfo: agentInfo ?? this.agentInfo,
          copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus);
}
