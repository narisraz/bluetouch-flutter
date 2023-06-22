import 'package:bluetouch/auth/domain/models/auth_exception.dart';

class AuthResult {
  final bool success;
  final AuthException? exception;

  AuthResult({required this.success, this.exception});
}
