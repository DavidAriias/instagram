import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/models/models.dart';
import 'package:instagram/app/useCases/auth/register_usecase.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/infraestructure/errors/auth_error.dart';
import 'package:instagram/presentation/enums/enums.dart';

import '../../../config/dependenciesInjection/instances_container.dart';
import '../../../domain/entities/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(loginUseCase, registerUseCase, authUseCase);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthUseCase _authUseCase;
  AuthNotifier(this._loginUseCase, this._registerUseCase, this._authUseCase)
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(LoginFormData form) async {
    try {
      final auth = await _loginUseCase.signIn(form);
      if (auth.error != null) {
        throw AuthException(auth.error!);
      }
      _setLoggedUser(auth);
    } on AuthException catch (e) {
      logout(e.message);
    }
  }

  void registerUser(RegisterFormData form) async {
    _registerUseCase.register(form);
  }

  void checkAuthStatus() async {
    try {
      final auth = await _loginUseCase.checkStatus();
      if (auth == null) {
        logout();
      } else {
        _setLoggedUser(auth);
      }
    } on AuthException catch (e) {
      logout(e.message);
    }
  }

  void _setLoggedUser(Auth auth) async {
    await _authUseCase.saveAuthLocally(auth);
    state = state.copyWith(
      auth: auth,
      status: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    try {
      await _loginUseCase.logout();
    } on AuthException catch (e) {
      errorMessage = e.message;
    }

    state = state.copyWith(
        auth: null,
        status: AuthStatus.notAuthenticated,
        errorMessage: errorMessage);
  }
}

class AuthState {
  final AuthStatus status;
  final Auth? auth;
  final String errorMessage;

  AuthState(
      {this.status = AuthStatus.checking, this.auth, this.errorMessage = ''});

  AuthState copyWith({AuthStatus? status, Auth? auth, String? errorMessage}) =>
      AuthState(
          status: status ?? this.status,
          auth: auth ?? this.auth,
          errorMessage: errorMessage ?? this.errorMessage);
}
