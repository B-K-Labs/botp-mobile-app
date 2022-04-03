class KUserData {
  static const session = "session_data";
  static const transaction = "transaction_data";
  static const preference = "preference_data";
  static const credentialSession = "credential_session_data";
  static const credentialKeys = "credential_key_data";
  static const credentialAccount = "credential_account_data";
  static const credentialProfile = "credential_profile_data";
}

// Session type: 0: first-time-user, 1: Signed out user, 2: Temporarily signed out user, 3: Authenticated user
enum SessionType {
  firstTime,
  unauthenticated,
  expired,
  authenticated,
}
