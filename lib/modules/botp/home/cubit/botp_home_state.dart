class BOTPHomeState {
  // Store globally public data
  bool? didKyc;
  String? bcAddress;
  String? avatarUrl;
  String? fullName;

  BOTPHomeState({this.didKyc, this.bcAddress, this.avatarUrl, this.fullName});

  BOTPHomeState copyWith(
          {bool? didKyc,
          String? bcAddress,
          String? avatarUrl,
          String? fullName}) =>
      BOTPHomeState(
          didKyc: didKyc ?? this.didKyc,
          bcAddress: bcAddress ?? this.bcAddress,
          avatarUrl: avatarUrl ?? this.avatarUrl,
          fullName: fullName ?? this.fullName);
}
