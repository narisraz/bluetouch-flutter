import 'package:bluetouch/auth/domain/models/auth_result.dart';

abstract class Login {
  Future<AuthResult> execute(String email, String password);
}
