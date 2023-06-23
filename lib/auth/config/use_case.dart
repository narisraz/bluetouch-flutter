import 'package:bluetouch/auth/config/repository.dart';
import 'package:bluetouch/auth/domain/usecases/interfaces/login.dart';
import 'package:bluetouch/auth/domain/usecases/interfaces/logout.dart';
import 'package:bluetouch/auth/domain/usecases/login_use_case.dart';
import 'package:bluetouch/auth/domain/usecases/logout_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_case.g.dart';

@riverpod
Login login(LoginRef ref) => LoginUseCase(ref.read(authRepositoryProvider));

@riverpod
Logout logout(LogoutRef ref) =>
    LogoutUseCase(authRepository: ref.read(authRepositoryProvider));
