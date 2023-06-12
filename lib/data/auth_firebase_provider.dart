import 'package:bluetouch/auth/models/auth_user.dart';
import 'package:bluetouch/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseProvider extends AuthProvider {
  late final FirebaseAuth _firebaseAuth;

  AuthFirebaseProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<AuthUser?> login(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = userCredential.user;
      if (user != null) {
        return AuthUser(user.uid, user.email!);
      }
      return Future.value();
    } on Exception catch (e) {
      return Future.value();
    }
  }

  @override
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }
}
