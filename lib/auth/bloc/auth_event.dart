part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthEventInitial extends AuthEvent {
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
