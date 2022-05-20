import 'package:botp_auth/common/models/common_model.dart';
import 'dart:math';

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

// (Easter egg)
// Simulate to manipulate provenance data functions
const _paddingHeadLength = 8;
const _headBcLength = 2;
const _paddingTailLength = 6;
const _chars = 'AaBbCcDdEeFf1234567890';
Random _rnd = Random();
String _makeRandomHexString(int length) =>
    String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String _makeEventFieldInvalid(String validField, [isHexString = true]) =>
    '${isHexString ? '0x${_makeRandomHexString(_paddingHeadLength - _headBcLength)}' : _makeRandomHexString(_paddingHeadLength)}$validField${_makeRandomHexString(_paddingTailLength)}';
String _makeEventFieldValid(String invalidField, [isHexString = true]) =>
    invalidField.substring(
        _paddingHeadLength, invalidField.length - _paddingTailLength);
BroadcastEventData modifyBroadcastEventData(
    BroadcastEventData data, int index, bool isBroadcastValid) {
  // If currently valid, make it invalid (and vice versa)
  String Function(String, [bool]) modifyFunction =
      isBroadcastValid ? _makeEventFieldInvalid : _makeEventFieldValid;
  // Modify data and return
  switch (index) {
    case 1:
      return data.copyWith(
          userBcAddress: modifyFunction(data.userBcAddress, true));
    case 2:
      return data.copyWith(id: modifyFunction(data.id, true));
    case 3:
      return data.copyWith(
          encryptedMessage: modifyFunction(data.encryptedMessage, false));
    case 0:
    default:
      return data.copyWith(
          agentBcAddress: modifyFunction(data.agentBcAddress, true));
  }
}

int chooseRandomBroadcastField() => Random().nextInt(4);
