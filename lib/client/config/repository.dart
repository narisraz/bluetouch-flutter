import 'package:bluetouch/client/data/repository/address_firestore_repository.dart';
import 'package:bluetouch/client/data/repository/branchement_firestore_repository.dart';
import 'package:bluetouch/client/data/repository/client_firestore_repository.dart';
import 'package:bluetouch/client/domain/repository/address_repository.dart';
import 'package:bluetouch/client/domain/repository/branchement_repository.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository.g.dart';

@riverpod
BranchementRepository branchementRepository(BranchementRepositoryRef ref) =>
    BranchementFirestoreRepository(
        firebaseFirestore: FirebaseFirestore.instance);

@riverpod
ClientRepository clientRepository(ClientRepositoryRef ref) =>
    ClientFirestoreRepository(
        firebaseFirestore: FirebaseFirestore.instance,
        addressRepository: ref.read(addressRepositoryProvider));

@riverpod
AddressRepository addressRepository(AddressRepositoryRef ref) =>
    AddressFirestoreRepository(firebaseFirestore: FirebaseFirestore.instance);
