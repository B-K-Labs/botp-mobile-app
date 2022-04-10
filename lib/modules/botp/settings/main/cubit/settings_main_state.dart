class SettingsMainState {
  String? avatarUrl;
  String? fullName;
  String guestName;
  String? bcAddress;
  get didKyc => fullName != null;

  SettingsMainState(
      {this.avatarUrl,
      this.fullName,
      this.bcAddress,
      this.guestName = "Guest"});

  SettingsMainState copyWith(
          {String? avatarUrl, String? fullName, String? bcAddress}) =>
      SettingsMainState(
          avatarUrl: avatarUrl ?? this.avatarUrl,
          fullName: fullName ?? this.fullName,
          bcAddress: bcAddress ?? this.bcAddress);
}
