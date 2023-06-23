import 'package:bluetouch/auth/config/repository.dart';
import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

@riverpod
class AuthState extends _$AuthState {
  AuthUser? currentUser;

  @override
  AuthUser? build() => currentUser;

  setLoggedOut() {
    state = null;
  }

  setLoggedIn() async {
    state = await ref.read(authRepositoryProvider).getCurrentLoggedInUser();
  }
}
