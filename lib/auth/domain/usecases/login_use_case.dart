import 'package:bluetouch/auth/domain/models/auth_result.dart';
import 'package:bluetouch/auth/domain/repository/auth_repository.dart';
import 'package:bluetouch/auth/domain/usecases/login.dart';

class LoginUseCase extends Login {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<AuthResult> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}
