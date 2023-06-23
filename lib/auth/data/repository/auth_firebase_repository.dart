import 'dart:async';

import 'package:bluetouch/auth/domain/models/auth_exception.dart';
import 'package:bluetouch/auth/domain/models/auth_result.dart';
import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:bluetouch/auth/domain/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseRepository extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthFirebaseRepository(
      {required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<AuthResult> login(String email, String password) async {
    var userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    var user = userCredential.user;
    if (user != null) {
      final AuthUser? authUser = await getCurrentLoggedInUser();
      return AuthResult(
        success: true,
        authUser: authUser,
      );
    }
    return AuthResult(success: false, exception: BadCredentialException());
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut();
  }

  @override
  Future<AuthUser?> getCurrentLoggedInUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      var userDocument = await firebaseFirestore
          .collection("users")
          .where("userName", isEqualTo: user.email)
          .get();
      return AuthUser.fromJson(userDocument.docs.first.data());
    }
    return null;
  }
}
