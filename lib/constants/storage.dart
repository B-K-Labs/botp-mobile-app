class UserDataType {
  static const session = "session_data";
  static const preferences = "preferences_data";
  static const credentialTransactions = "credential_transactions_data";
  static const credentialSession = "credential_session_data";
  static const credentialAgents = "credential_agents_data";
  static const credentialAccount = "credential_account_data";
  static const credentialProfile = "credential_profile_data";
}

// Session
// - Session type: first-time-user, signed out user, temporarily signed out user, and authenticated user
enum SessionType {
  firstTime,
  unauthenticated,
  expired,
  authenticated,
}

// Preference
// - Language
enum Language {
  en,
  vn,
}

// App theme
enum AppTheme {
  light,
  dark,
}

// Display
enum TransactionDisplayingType {
  normal,
  condensed,
}
