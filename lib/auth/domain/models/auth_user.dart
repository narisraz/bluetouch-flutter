import 'package:equatable/equatable.dart';

enum AuthUserRole { gestionnaire, caissier, releveur }

class AuthUser extends Equatable {
  final String userName;
  final String name;
  final String? firstName;
  final AuthUserRole? role;

  const AuthUser(
      {required this.userName, required this.name, this.firstName, this.role});

  static AuthUser fromJson(Map<String, dynamic> data) {
    return AuthUser(
        name: data['name'],
        firstName: data['firstName'],
        userName: data['userName'],
        role: AuthUserRole.values.byName(data['role']));
  }

  @override
  List<Object?> get props => [userName];
}
