import 'package:bluetouch/auth/domain/models/auth_exception.dart';
import 'package:bluetouch/auth/domain/models/auth_user.dart';

class AuthResult {
  final bool success;
  final AuthUser? authUser;
  final AuthException? exception;

  AuthResult({required this.success, this.exception, this.authUser});
}
