extension EnumTemplate<T> on List<T> {
  List<T> get values => this;
}

T enumFromValue<T>(List<T> listType, String value) {
  return listType.values.firstWhere((e) => e.toString() == value);
}
