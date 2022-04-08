// Profiles in settings
String? fullNameValidator(String fullName) =>
    fullName.isEmpty ? "Missing full name" : null;

String? ageValidator(int age) => age < 0 && age > 100 ? "Invalid age" : null;

String? addressValidator(String address) =>
    address.isEmpty ? "Missing address" : null;

String? debitorValidator(String debitor) => debitor.isEmpty
    ? "Missing phone number"
    : RegExp(r'''^\d{10,12}$''').hasMatch(debitor)
        ? null
        : "Invalid phone number";
