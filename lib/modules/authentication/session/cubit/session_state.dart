abstract class SessionState {}

// When open app
class UnknownSessionState extends SessionState {}

// First-time user
class FirstTimeSessionState extends SessionState {}

// Completely signed out user
class UnauthenticatedSessionState extends SessionState {}

// Out-of-session user i.e only password is required when signing in
class ExpiredSessionState extends SessionState {}

// Signed in user
class AuthenticatedSessionState extends SessionState {}
