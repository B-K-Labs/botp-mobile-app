// Profiles in settings
String? fullNameValidator(String? fullName) =>
    fullName == null || fullName.isEmpty ? "Missing full name" : null;

String? addressValidator(String? address) =>
    address == null || address.isEmpty ? "Missing address" : null;

String? genderValidator(String? gender) =>
    gender == null || gender.isEmpty ? "Missing gender" : null;

String? ageValidator(String? age) {
  if (age == null) return "Missing age";
  try {
    final ageNumber = int.parse(age);
    return ageNumber < 0 && ageNumber > 200 ? "Invalid age" : null;
  } on Exception catch (e) {
    return e.toString();
  }
}

String? debitorValidator(String? debitor) => debitor == null || debitor.isEmpty
    ? "Missing phone number"
    : RegExp(r'''^\d{10,12}$''').hasMatch(debitor)
        ? null
        : "Invalid phone number";
