abstract class AccountSetupKYCEvent {}

class AccountSetupKYCEventFullNameChanged extends AccountSetupKYCEvent {
  final String? fullName;
  AccountSetupKYCEventFullNameChanged(this.fullName);
}

class AccountSetupKYCEventAddressChanged extends AccountSetupKYCEvent {
  final String? address;
  AccountSetupKYCEventAddressChanged(this.address);
}

class AccountSetupKYCEventAgeChanged extends AccountSetupKYCEvent {
  final String? age;
  AccountSetupKYCEventAgeChanged(this.age);
}

class AccountSetupKYCEventGenderChanged extends AccountSetupKYCEvent {
  final String? gender;
  AccountSetupKYCEventGenderChanged(this.gender);
}

class AccountSetupKYCEventDebitorChanged extends AccountSetupKYCEvent {
  final String? debitor;
  AccountSetupKYCEventDebitorChanged(this.debitor);
}

class AccountSetupKYCEventSubmitted extends AccountSetupKYCEvent {}
