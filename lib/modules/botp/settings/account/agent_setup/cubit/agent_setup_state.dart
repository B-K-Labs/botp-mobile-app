import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class AccountAgentSetupState {
  final RequestStatus setupAgentStatus;
  final AgentInfo? agentInfo;

  AccountAgentSetupState(
      {this.setupAgentStatus = const RequestStatusInitial(), this.agentInfo});

  AccountAgentSetupState copyWith(
          {RequestStatus? setupAgentStatus, AgentInfo? agentInfo}) =>
      AccountAgentSetupState(
          setupAgentStatus: setupAgentStatus ?? this.setupAgentStatus,
          agentInfo: agentInfo ?? this.agentInfo);
}
