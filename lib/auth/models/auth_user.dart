import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String email;

  const AuthUser(this.id, this.email);

  @override
  List<Object?> get props => [id, email];
}
