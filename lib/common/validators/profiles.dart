// Profiles in settings
String? fullNameValidator(String? fullName) =>
    fullName == null || fullName.isEmpty ? "Missing full name" : null;

String? ageValidator(int? age) => age == null
    ? "Missing age"
    : age < 0 && age > 200
        ? "Invalid age"
        : null;

String? genderValidator(String? gender) =>
    gender == null || gender.isEmpty ? "Missing gender" : null;

String? debitorValidator(String? debitor) => debitor == null || debitor.isEmpty
    ? "Missing phone number"
    : RegExp(r'''^\d{10,12}$''').hasMatch(debitor)
        ? null
        : "Invalid phone number";
