import 'package:bluetouch/client/domain/usecases/add_branchement_use_case.dart';
import 'package:bluetouch/client/domain/usecases/get_all_saep_client_use_case.dart';
import 'package:bluetouch/client/domain/usecases/get_barnchement_use_case.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/add_branchement.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/get_all_saep_client.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/get_branchement.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/update_client_category.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/update_client_state.dart';
import 'package:bluetouch/client/domain/usecases/update_client_category_use_case.dart';
import 'package:bluetouch/client/domain/usecases/update_client_state_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'module_repository.dart';

part 'module_use_case.g.dart';

@riverpod
GetAllSaepClient getAllSaepClient(GetAllSaepClientRef ref) =>
    GetAllSaepClientUseCase(
        clientRepository: ref.read(clientRepositoryProvider));

@riverpod
UpdateClientState updateClientState(UpdateClientStateRef ref) =>
    UpdateClientStateUseCase(
        clientRepository: ref.read(clientRepositoryProvider));

@riverpod
UpdateClientCategory updateClientCategory(UpdateClientCategoryRef ref) =>
    UpdateClientCategoryUseCase(
        clientRepository: ref.read(clientRepositoryProvider));

@riverpod
GetBranchement getBranchement(GetBranchementRef ref) => GetBranchementUseCase(
    branchementRepository: ref.read(branchementRepositoryProvider));

@riverpod
AddBranchement addBranchement(AddBranchementRef ref) => AddBranchementUseCase(
    branchementRepository: ref.read(branchementRepositoryProvider));
