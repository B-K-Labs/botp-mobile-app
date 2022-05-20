import 'package:botp_auth/constants/provenance.dart';

abstract class ProvenanceDetailEvent {
  const ProvenanceDetailEvent();
}

class ProvenanceEventGetProvenanceEvents extends ProvenanceDetailEvent {}

class ProvenanceEventCopyData extends ProvenanceDetailEvent {
  final String dataName;
  final String dataValue;

  ProvenanceEventCopyData({required this.dataName, required this.dataValue});
}

class ProvenanceEventScanBlockchainExplorer extends ProvenanceDetailEvent {
  final ProvenanceEventType eventType;

  ProvenanceEventScanBlockchainExplorer({required this.eventType});
}
