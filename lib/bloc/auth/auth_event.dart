abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class ForceLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {}

class ResetStateEvent extends AuthEvent {}
