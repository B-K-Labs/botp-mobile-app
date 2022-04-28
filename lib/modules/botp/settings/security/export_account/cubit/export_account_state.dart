import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';

class SecurityExportAccountState {
  final bool isHiddenQrImage;
  final String? privateKey;
  final String? bcAddress;
  final LoadUserDataStatus loadUserDataStatus;
  final RequestStatus saveQrImageStatus;

  SecurityExportAccountState(
      {this.isHiddenQrImage = true,
      this.privateKey,
      this.bcAddress,
      this.loadUserDataStatus = const LoadUserDataStatusInitial(),
      this.saveQrImageStatus = const RequestStatusInitial()});

  SecurityExportAccountState copyWith(
          {bool? isHiddenQrImage,
          String? privateKey,
          String? bcAddress,
          LoadUserDataStatus? loadUserDataStatus,
          RequestStatus? saveQrImageStatus}) =>
      SecurityExportAccountState(
          isHiddenQrImage: isHiddenQrImage ?? this.isHiddenQrImage,
          privateKey: privateKey ?? this.privateKey,
          loadUserDataStatus: loadUserDataStatus ?? this.loadUserDataStatus,
          saveQrImageStatus: saveQrImageStatus ?? this.saveQrImageStatus);
}
