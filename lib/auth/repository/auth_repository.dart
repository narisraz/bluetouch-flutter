import 'package:bluetouch/auth/models/auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser?> login(String email, String password);
}
