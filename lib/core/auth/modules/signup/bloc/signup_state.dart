class SignUpState {
  final String password;
  bool get isValidPassword => RegExp(
          r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\`\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\{\]\}\\\|\;\:\'\"\,\<\.\>\/\?]).{8,}$''')
      .hasMatch(password);

  SignUpState({this.password = ''});

  SignUpState copyWith({
    required String password,
  }) {
    return SignUpState(password: password);
  }
}
