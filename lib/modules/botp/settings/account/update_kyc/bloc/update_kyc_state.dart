import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/common/validators/profiles.dart';

class AccountUpdateKYCState {
  // User data
  LoadUserDataStatus loadUserDataStatus;
  // Profile
  String? fullName;
  String? address;
  String? age;
  String? gender;
  String? debitor;
  // Form
  RequestStatus formStatus;
  // Validators
  String? get validateFullName => fullNameValidator(fullName);
  String? get validateAddress => addressValidator(fullName);
  String? get validateAge => ageValidator(age);
  String? get validateGender => genderValidator(gender);
  String? get validateDebitor => debitorValidator(debitor);

  AccountUpdateKYCState(
      {this.fullName,
      this.address,
      this.age,
      this.gender,
      this.debitor,
      this.formStatus = const RequestStatusInitial(),
      this.loadUserDataStatus = const LoadUserDataStatusInitial()});

  AccountUpdateKYCState copyWith(
          {String? fullName,
          String? address,
          String? age,
          String? gender,
          String? debitor,
          RequestStatus? formStatus,
          LoadUserDataStatus? loadUserDataStatus}) =>
      AccountUpdateKYCState(
          fullName: fullName ?? this.fullName,
          address: address ?? this.address,
          age: age ?? this.age,
          gender: gender ?? this.gender,
          debitor: debitor ?? this.debitor,
          formStatus: formStatus ?? this.formStatus,
          loadUserDataStatus: loadUserDataStatus ?? this.loadUserDataStatus);
}
