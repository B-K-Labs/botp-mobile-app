import 'package:botp_auth/constants/provenance.dart';

abstract class ProvenanceEvent {
  const ProvenanceEvent();
}

class ProvenanceEventGetProvenanceEvents extends ProvenanceEvent {}

class ProvenanceEventCopyData extends ProvenanceEvent {
  final String dataName;
  final String dataValue;

  ProvenanceEventCopyData({required this.dataName, required this.dataValue});
}

class ProvenanceEventScanBlockchainExplorer extends ProvenanceEvent {
  final ProvenanceEventType eventType;

  ProvenanceEventScanBlockchainExplorer({required this.eventType});
}
