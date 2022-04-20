// Type for user data
class UserDataType {
  static const credentialSession = "credential_session_data";
  static const credentialPreferences = "credential_preferences_data";
  static const credentialTransactions = "credential_transactions_data";
  static const credentialAgents = "credential_agents_data";
  static const credentialAccount = "credential_account_data";
  static const credentialProfile = "credential_profile_data";
}

// Session
enum UserDataSession {
  firstTime,
  unauthenticated,
  expired,
  authenticated,
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
