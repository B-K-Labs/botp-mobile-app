import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_event.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvenanceBloc extends Bloc<ProvenanceEvent, ProvenanceState> {
  // Repository
  AuthenticatorRepository authenticatorRepository;

  // Flag
  bool _isGettingProvenanceInfo = false;
  bool _isScanningProvenanceEvents = false;
  bool _isCopyingData = false;

  ProvenanceBloc({required this.authenticatorRepository}) : super(ProvenanceState()) {
    on<ProvenanceEventGetProvenanceEvents>((event, emit) async {
      if (_isGettingProvenanceInfo) return;
      _isGettingProvenanceInfo = true;

      try {
        emit(state.copyWith(getProvenanceStatus: RequestStatusSubmitting()));

        Future<List<>>

        emit(state.copyWith(getProvenanceStatus: RequestStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(getProvenanceStatus: RequestStatusFailed(e)));
      }
      _isGettingProvenanceInfo = false;
    });

    on<ProvenanceEventScanBlockchainExplorer>((event, emit) async {});

    on<ProvenanceEventCopyData>((event, emit) async {});
  }
}
