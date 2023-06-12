import 'dart:async';

import 'package:bluetouch/auth/models/auth_user.dart';
import 'package:bluetouch/auth/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final BuildContext _context;
  late final AuthProvider _authRepository;

  AuthBloc(this._context) : super(const AuthState()) {
    _authRepository = RepositoryProvider.of(_context);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventInitial>(_onAuthInitial);
  }

  FutureOr<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    try {
      final authUser = await _authRepository.login(event.email, event.password);
      if (authUser != null) {
        emit(AuthState(
            authenticatedUser: authUser, authStatus: AuthStatus.loggedIn));
      } else {
        emit(const AuthState(authStatus: AuthStatus.fail));
      }
    } catch (e) {
      emit(const AuthState(authStatus: AuthStatus.fail));
    }
  }

  FutureOr<void> _onAuthInitial(
      AuthEventInitial event, Emitter<AuthState> emit) {
    emit(const AuthState());
  }
}
