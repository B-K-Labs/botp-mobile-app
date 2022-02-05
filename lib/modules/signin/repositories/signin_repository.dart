class SignInRepository {
  Future<void> signIn() async {
    print('Attempting sign in');
    Future.delayed(const Duration(seconds: 3));
    print('Signed in');
  }
}
