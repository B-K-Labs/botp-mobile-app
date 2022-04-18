import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';

class SettingsHomeState {
  LoadUserDataStatus loadUserDataStatus;
  // Profile
  String? avatarUrl;
  String? fullName;
  String guestName;
  get didKyc => fullName != null;
  // Account
  String? bcAddress;
  SetClipboardStatus copyBcAddressStatus;

  SettingsHomeState(
      {this.avatarUrl,
      this.fullName,
      this.bcAddress,
      this.guestName = "Guest",
      this.copyBcAddressStatus = const SetClipboardStatusInitial(),
      this.loadUserDataStatus = const LoadUserDataStatusInitial()});

  SettingsHomeState copyWith(
          {LoadUserDataStatus? loadUserData,
          String? avatarUrl,
          String? fullName,
          String? bcAddress,
          SetClipboardStatus? copyBcAddressStatus}) =>
      SettingsHomeState(
          loadUserDataStatus: loadUserData ?? this.loadUserDataStatus,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          fullName: fullName ?? this.fullName,
          bcAddress: bcAddress ?? this.bcAddress,
          copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus);
}
