abstract class AuthException {}

class BadCredentialException extends AuthException {}

class UnauthorizedException extends AuthException {}
