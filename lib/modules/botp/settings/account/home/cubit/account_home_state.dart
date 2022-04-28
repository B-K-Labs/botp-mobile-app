import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';

class ProfileViewState {
  LoadUserDataStatus loadUserData;
  // Profile
  String? fullName;
  String? address;
  int? age;
  String? gender;
  String? debitor;
  bool? didKyc;
  // Account
  String? bcAddress;
  String? publicKey;
  SetClipboardStatus copyBcAddressStatus;

  ProfileViewState(
      {this.fullName,
      this.address,
      this.age,
      this.gender,
      this.debitor,
      this.didKyc,
      this.bcAddress,
      this.publicKey,
      this.copyBcAddressStatus = const SetClipboardStatusInitial(),
      this.loadUserData = const LoadUserDataStatusInitial()});
  ProfileViewState copyWith(
          {LoadUserDataStatus? loadUserData,
          String? fullName,
          String? address,
          int? age,
          String? gender,
          String? debitor,
          bool? didKyc,
          String? bcAddress,
          String? publicKey,
          SetClipboardStatus? copyBcAddressStatus}) =>
      ProfileViewState(
          loadUserData: loadUserData ?? this.loadUserData,
          fullName: fullName ?? this.fullName,
          address: address ?? this.address,
          age: age ?? this.age,
          gender: gender ?? this.gender,
          debitor: debitor ?? this.debitor,
          didKyc: didKyc ?? this.didKyc,
          bcAddress: bcAddress ?? this.bcAddress,
          publicKey: publicKey ?? this.publicKey,
          copyBcAddressStatus: copyBcAddressStatus ?? this.copyBcAddressStatus);
}
