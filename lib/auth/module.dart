import 'package:bluetouch/auth/data/repository/module.dart';
import 'package:bluetouch/auth/domain/usecases/login.dart';
import 'package:bluetouch/auth/domain/usecases/login_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'module.g.dart';

@riverpod
Login login(LoginRef ref) => LoginUseCase(ref.read(authRepositoryProvider));
