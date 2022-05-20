import 'package:botp_auth/common/models/common_model.dart';

ProvenanceMatchingInfo compareProvenanceEvents(
        BroadcastEventData? broadcastEventData,
        HistoryEventData? historyEventData) =>
    ProvenanceMatchingInfo(
        agentBcAddress: broadcastEventData?.agentBcAddress ==
            historyEventData?.agentBcAddress,
        userBcAddress: broadcastEventData?.userBcAddress ==
            historyEventData?.userBcAddress,
        id: broadcastEventData?.id == historyEventData?.id,
        encryptedMessage: broadcastEventData?.encryptedMessage ==
            historyEventData?.encryptedMessage);
