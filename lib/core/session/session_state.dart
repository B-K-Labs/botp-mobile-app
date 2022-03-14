abstract class SessionState {}

// When open app
class UnknownSessionState extends SessionState {}

// Completely signed out
class BlankSessionState extends SessionState {}

// When out-of-session, just requires password
class UnauthenticatedSessionState extends SessionState {}

// Can access the app
class AuthenticatedSessionState extends SessionState {}
