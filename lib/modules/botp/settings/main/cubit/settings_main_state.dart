import 'package:botp_auth/common/states/set_clipboard_status.dart';

class SettingsMainState {
  String? avatarUrl;
  String? fullName;
  String guestName;
  String? bcAddress;
  get didKyc => fullName != null;
  SetClipboardStatus copyBcAddressStatus;

  SettingsMainState(
      {this.avatarUrl,
      this.fullName,
      this.bcAddress,
      this.guestName = "Guest",
      this.copyBcAddressStatus = const SetClipboardStatusInitial()});

  SettingsMainState copyWith(
          {String? avatarUrl,
          String? fullName,
          String? bcAddress,
          SetClipboardStatus? copyBcAddressStatus}) =>
      SettingsMainState(
          avatarUrl: avatarUrl ?? this.avatarUrl,
          fullName: fullName ?? this.fullName,
          bcAddress: bcAddress ?? this.bcAddress,
          copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus);
}
