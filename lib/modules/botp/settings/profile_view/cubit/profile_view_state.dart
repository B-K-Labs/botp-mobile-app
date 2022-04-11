import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';

class ProfileViewState {
  LoadUserDataStatus loadUserData;
  // Profile
  String? fullName;
  int? age;
  String? gender;
  String? debitor;
  // Account
  String? bcAddress;
  String? publicKey;
  SetClipboardStatus copyBcAddressStatus;
  bool get didKyc => fullName != null;

  ProfileViewState(
      {this.fullName,
      this.age,
      this.gender,
      this.debitor,
      this.bcAddress,
      this.publicKey,
      this.copyBcAddressStatus = const SetClipboardStatusInitial(),
      this.loadUserData = const LoadUserDataStatusInitial()});
  ProfileViewState copyWith(
          {LoadUserDataStatus? loadUserData,
          String? fullName,
          int? age,
          String? gender,
          String? debitor,
          String? bcAddress,
          String? publicKey,
          SetClipboardStatus? copyBcAddressStatus}) =>
      ProfileViewState(
          loadUserData: loadUserData ?? this.loadUserData,
          fullName: fullName ?? this.fullName,
          age: age ?? this.age,
          gender: gender ?? this.gender,
          debitor: debitor ?? this.debitor,
          bcAddress: bcAddress ?? this.bcAddress,
          publicKey: publicKey ?? this.publicKey,
          copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus);
}
