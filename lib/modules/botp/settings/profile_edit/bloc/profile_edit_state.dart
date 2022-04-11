import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/common/validators/profiles.dart';

class ProfileEditState {
  // User data
  LoadUserDataStatus loadUserDataStatus;
  // Profile
  String? fullName;
  int? age;
  String? gender;
  String? debitor;
  // Form
  RequestStatus formStatus;
  // Validators
  String? get validateFullName => fullNameValidator(fullName);
  String? get validateAge => ageValidator(age);
  String? get validateGender => fullNameValidator(gender);
  String? get validateDebitor => fullNameValidator(debitor);

  ProfileEditState(
      {this.fullName,
      this.age,
      this.gender,
      this.debitor,
      this.formStatus = const RequestStatusInitial(),
      this.loadUserDataStatus = const LoadUserDataStatusInitial()});

  ProfileEditState copyWith(
          {String? fullName,
          int? age,
          String? gender,
          String? debitor,
          RequestStatus? formStatus,
          LoadUserDataStatus? loadUserData}) =>
      ProfileEditState(
          fullName: fullName ?? this.fullName,
          age: age ?? this.age,
          gender: gender ?? this.gender,
          debitor: debitor ?? this.debitor,
          formStatus: formStatus ?? this.formStatus,
          loadUserDataStatus: loadUserData ?? this.loadUserDataStatus);
}
