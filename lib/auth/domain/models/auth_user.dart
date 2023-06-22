import 'package:equatable/equatable.dart';

enum AuthUserRole { admin }

class AuthUser extends Equatable {
  final String id;
  final String email;
  final AuthUserRole? role;

  const AuthUser({required this.id, required this.email, this.role});

  @override
  List<Object?> get props => [id, email];

  static AuthUser fromJson(Map<String, dynamic> data) {
    return AuthUser(
        email: data['email'],
        id: data['uid'],
        role: AuthUserRole.values.byName(data['role']));
  }
}
