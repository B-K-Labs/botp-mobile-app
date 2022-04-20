abstract class ProfileEditEvent {}

class ProfileEditEventFullNameChanged extends ProfileEditEvent {
  final String? fullName;
  ProfileEditEventFullNameChanged(this.fullName);
}

class ProfileEditEventAgeChanged extends ProfileEditEvent {
  final String? age;
  ProfileEditEventAgeChanged(this.age);
}

class ProfileEditEventGenderChanged extends ProfileEditEvent {
  final String? gender;
  ProfileEditEventGenderChanged(this.gender);
}

class ProfileEditEventDebitorChanged extends ProfileEditEvent {
  final String? debitor;
  ProfileEditEventDebitorChanged(this.debitor);
}

class ProfileEditEventSubmitted extends ProfileEditEvent {}
