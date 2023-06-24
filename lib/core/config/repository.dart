import 'package:bluetouch/core/data/repository/saep_firestore_repository.dart';
import 'package:bluetouch/core/domain/repository/saep_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository.g.dart';

@riverpod
SaepRepository saepRepository(SaepRepositoryRef ref) =>
    SaepFirestoreRepository(firebaseFirestore: FirebaseFirestore.instance);
