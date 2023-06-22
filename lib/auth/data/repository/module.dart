import 'package:bluetouch/auth/data/repository/auth_firebase_repository.dart';
import 'package:bluetouch/auth/domain/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'module.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthFirebaseRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance);
