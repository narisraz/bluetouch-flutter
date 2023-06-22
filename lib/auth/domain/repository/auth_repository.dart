import 'package:bluetouch/auth/domain/models/auth_result.dart';
import 'package:bluetouch/auth/domain/models/auth_user.dart';

abstract class AuthRepository {
  Future<AuthResult> login(String email, String password);

  Future<void> logout();

  Future<AuthUser?> getCurrentLoggedInUser();
}
