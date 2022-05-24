import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/constants/provenance.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_event.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_state.dart';
import 'package:botp_auth/utils/helpers/provenance.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvenanceBloc extends Bloc<ProvenanceEvent, ProvenanceState> {
  // Repository
  AuthenticatorRepository authenticatorRepository;

  // Flag
  bool _isGettingProvenanceInfo = false;
  bool _isCopyingData = false;
  bool _isChangingData = false;

  // Easter egg
  int _broadcastFieldIndex = 0;
  bool _isBroadcastValid = true;

  ProvenanceBloc({required this.authenticatorRepository})
      : super(ProvenanceState()) {
    on<ProvenanceEventGetProvenanceEvents>((event, emit) async {
      if (_isGettingProvenanceInfo) return;
      _isGettingProvenanceInfo = true;

      try {
        emit(state.copyWith(getProvenanceStatus: RequestStatusSubmitting()));
        // Get provenance events
        final provenanceInfo = event.provenanceInfo;
        _getBroadcastEventAsync() async => await authenticatorRepository
            .getProvenanceEvent(ProvenanceEventType.broadcast, provenanceInfo);
        _getHistoryEventAsync() async => await authenticatorRepository
            .getProvenanceEvent(ProvenanceEventType.history, provenanceInfo);
        List<ProvenanceEventResponseModel> provenanceEventsList =
            await Future.wait(
                [_getBroadcastEventAsync(), _getHistoryEventAsync()]);
        // - Get result
        final _broadcastEventData = provenanceEventsList
            .where((event) => event.eventType == ProvenanceEventType.broadcast)
            .toList()[0]
            .broadcastEventData;
        final _historyEventData = provenanceEventsList
            .where((event) => event.eventType == ProvenanceEventType.history)
            .toList()[0]
            .historyEventData;
        // - Compare events
        final _matchingInfo =
            compareProvenanceEvents(_broadcastEventData, _historyEventData);
        // - Update state
        emit(state.copyWith(
            getProvenanceStatus: RequestStatusSuccess(),
            broadcastEventData: _broadcastEventData,
            historyEventData: _historyEventData,
            matchingInfo: _matchingInfo));
      } on Exception catch (e) {
        emit(state.copyWith(getProvenanceStatus: RequestStatusFailed(e)));
      }
      _isGettingProvenanceInfo = false;
    });

    on<ProvenanceEventCopyData>((event, emit) async {
      if (_isCopyingData) return;
      _isCopyingData = true;
      emit(state.copyWith(copyDataStatus: SetClipboardStatusSubmitting()));
      try {
        await setClipboardData(event.dataValue);
        emit(state.copyWith(
            copyDataStatus: SetClipboardStatusSuccess(
                message: '${event.dataName} copied.')));
      } on Exception catch (e) {
        emit(state.copyWith(copyDataStatus: SetClipboardStatusFailed(e)));
      }
      emit(state.copyWith(copyDataStatus: const SetClipboardStatusInitial()));
      _isCopyingData = false;
    });

    // Make broadcast field invalid
    on<ProvenanceEventEasterEgg>((event, emit) async {
      final broadcastEventData = state.broadcastEventData;
      if (_isChangingData || broadcastEventData == null) return;
      _isChangingData = true;
      // Choose new index field when currently valid
      if (_isBroadcastValid) {
        _broadcastFieldIndex = chooseRandomBroadcastField();
      }
      // Modify broadcast data
      final newBroadcastEventData = modifyBroadcastEventData(
          broadcastEventData, _broadcastFieldIndex, _isBroadcastValid);
      // Swap valid state
      _isBroadcastValid = !_isBroadcastValid;
      // Compare events
      final _matchingInfo = compareProvenanceEvents(
          newBroadcastEventData, state.historyEventData);
      // Update state
      emit(state.copyWith(
          broadcastEventData: newBroadcastEventData,
          matchingInfo: _matchingInfo));
      _isChangingData = false;
    });
  }
}
