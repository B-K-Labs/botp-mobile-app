abstract class SessionState {}

// When open app
class UnknownSessionState extends SessionState {}

// First-time user
class FirstTimeSessionState extends SessionState {}

// Completely signed out user
class UnauthenticatedSessionState extends SessionState {}

// Out-of-session user (i.e just requires password in the next sign in)
class ExpiredSessionState extends SessionState {}

// Signed in user
class AuthenticatedSessionState extends SessionState {}
