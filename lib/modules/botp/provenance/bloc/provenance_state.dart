import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/request_status.dart';

class ProvenanceState {
  final BroadcastEventData? broadcastEventData;
  final HistoryEventData? historyEventData;
  final ProvenanceMatchingInfo? matchingInfo;
  final RequestStatus getProvenanceStatus;

  ProvenanceState(
      {this.broadcastEventData,
      this.historyEventData,
      this.matchingInfo,
      this.getProvenanceStatus = const RequestStatusInitial()});

  ProvenanceState copyWith({
    BroadcastEventData? broadcastEventData,
    HistoryEventData? historyEventData,
    ProvenanceMatchingInfo? matchingInfo,
    RequestStatus? getProvenanceStatus,
  }) =>
      ProvenanceState(
          broadcastEventData: broadcastEventData ?? this.broadcastEventData,
          historyEventData: historyEventData ?? this.historyEventData,
          matchingInfo: matchingInfo ?? this.matchingInfo,
          getProvenanceStatus: getProvenanceStatus ?? this.getProvenanceStatus);
}
