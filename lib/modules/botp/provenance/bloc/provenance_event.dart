import 'package:botp_auth/common/models/common_model.dart';

abstract class ProvenanceEvent {
  const ProvenanceEvent();
}

class ProvenanceEventGetProvenanceEvents extends ProvenanceEvent {
  final ProvenanceInfo provenanceInfo;

  ProvenanceEventGetProvenanceEvents({required this.provenanceInfo});
}

class ProvenanceEventCopyData extends ProvenanceEvent {
  final String dataName;
  final String dataValue;

  ProvenanceEventCopyData({required this.dataName, required this.dataValue});
}

class ProvenanceEventEasterEgg extends ProvenanceEvent {}
