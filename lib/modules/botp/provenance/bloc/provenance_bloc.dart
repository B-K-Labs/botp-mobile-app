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
  bool _isScanningProvenanceEvents = false;
  bool _isCopyingData = false;

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

    on<ProvenanceEventScanBlockchainExplorer>((event, emit) async {
      if (_isScanningProvenanceEvents) return;
      _isScanningProvenanceEvents = true;
      // TODO: open webview
      _isScanningProvenanceEvents = false;
    });

    on<ProvenanceEventCopyData>((event, emit) async {
      if (_isCopyingData) return;
      _isCopyingData = true;
      emit(state.copyWith(copyData: SetClipboardStatusSubmitting()));
      try {
        await setClipboardData(event.dataValue);
        emit(state.copyWith(
            copyData: SetClipboardStatusSuccess(
                message: '${event.dataName} copied.')));
      } on Exception catch (e) {
        emit(state.copyWith(copyData: SetClipboardStatusFailed(e)));
      }
      _isCopyingData = false;
    });
  }
}
