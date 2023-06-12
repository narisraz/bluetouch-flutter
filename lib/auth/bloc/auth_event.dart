part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthEventInitial extends AuthEvent {
  final AuthStatus authStatus;
  final AuthUser? authUser;

  const AuthEventInitial({this.authStatus = AuthStatus.initial, this.authUser});

  @override
  List<Object?> get props => [];
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthEventLogout extends AuthEvent {
  @override
  List<Object?> get props => [];
}
