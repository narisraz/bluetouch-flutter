part of 'auth_bloc.dart';

enum AuthStatus { initial, inProgress, loggedIn, fail }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final AuthUser? authenticatedUser;

  const AuthState(
      {this.authStatus = AuthStatus.initial, this.authenticatedUser});

  @override
  List<Object?> get props => [authenticatedUser, authStatus];
}
