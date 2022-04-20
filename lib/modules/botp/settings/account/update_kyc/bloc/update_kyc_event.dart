abstract class AccountUpdateKYCEvent {}

class AccountUpdateKYCEventFullNameChanged extends AccountUpdateKYCEvent {
  final String? fullName;
  AccountUpdateKYCEventFullNameChanged(this.fullName);
}

class AccountUpdateKYCEventAddressChanged extends AccountUpdateKYCEvent {
  final String? address;
  AccountUpdateKYCEventAddressChanged(this.address);
}

class AccountUpdateKYCEventAgeChanged extends AccountUpdateKYCEvent {
  final String? age;
  AccountUpdateKYCEventAgeChanged(this.age);
}

class AccountUpdateKYCEventGenderChanged extends AccountUpdateKYCEvent {
  final String? gender;
  AccountUpdateKYCEventGenderChanged(this.gender);
}

class AccountUpdateKYCEventDebitorChanged extends AccountUpdateKYCEvent {
  final String? debitor;
  AccountUpdateKYCEventDebitorChanged(this.debitor);
}

class AccountUpdateKYCEventSubmitted extends AccountUpdateKYCEvent {}
