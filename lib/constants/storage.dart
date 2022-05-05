// Type for user data
class UserDataType {
  static const credentialSession = "credential_session_data";
  static const credentialPreferences = "credential_preferences_data";
  static const credentialTransactionsHistory =
      "credential_transactions_history_data";
  static const credentialTransactionsSecret =
      "credential_transactions_secret_data";
  static const credentialAgents = "credential_agents_data";
  static const credentialAccount = "credential_account_data";
  static const credentialProfile = "credential_profile_data";
  static const credentialKYC = "credential_kyc_data";
}

// Session
enum UserDataSession {
  unauthenticated,
  expired,
  // authenticated, (sign in is always required)
}

// Preference
// - Language
enum UserDataLanguage {
  en,
  vn,
}

// App theme
enum UserDataTheme {
  light,
  dark,
}

// Display
enum UserDataTransactionDisplaying {
  normal,
  condensed,
}
