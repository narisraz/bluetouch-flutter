import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:bluetouch/core/config/repository.dart';
import 'package:bluetouch/core/domain/models/saep.dart';
import 'package:bluetouch/core/domain/usecases/get_all_saep_by_user_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_case.g.dart';

@riverpod
Stream<Iterable<Saep>> getAllSaepByUser(
        GetAllSaepByUserRef ref, AuthUser authUser) =>
    GetAllSaepByUserUseCase(saepRepository: ref.read(saepRepositoryProvider))
        .execute(authUser);
