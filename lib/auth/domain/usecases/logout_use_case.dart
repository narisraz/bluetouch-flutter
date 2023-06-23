import 'package:bluetouch/auth/domain/repository/auth_repository.dart';
import 'package:bluetouch/auth/domain/usecases/interfaces/logout.dart';

class LogoutUseCase extends Logout {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  Future<void> execute() {
    return authRepository.logout();
  }
}
