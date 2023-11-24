import 'dart:convert';

import 'package:instagram/app/models/forms/login_form_data.dart';
import 'package:instagram/infraestructure/errors/auth_error.dart';
import 'package:instagram/infraestructure/mappers/auth_mapper.dart';

import '../../../domain/entities/auth.dart';
import '../../../domain/repositories/repositories.dart';
import '../../mappers/forms/login_mapper.dart';

class LoginUseCase {
  final AuthRepository _authRepository;
  final LocalRepository _localRepository;
//TODO: RFACTORIZAR AUTHUSECASE
  LoginUseCase(this._authRepository, this._localRepository);

  Future<Auth> signIn(LoginFormData value) async {
    final authMapper = LoginMapper.mapLoginFormDataToSignInUserInput(value);

    return _authRepository.signInUser(authMapper);
  }

  Future<Auth?> checkStatus() async {
    final auth = await _localRepository.getValue<String>('auth');

    if (auth == null) return null;

    try {
      final authMap = jsonDecode(auth);
      final authFromLocalStorage = AuthMapper.fromJson(authMap);
      final authApi = AuthMapper.mapAuthEntityToAuthInput(authFromLocalStorage);
      final authResponse = await _authRepository.checkTokenStatus(authApi);

      await _localRepository.setKeyValue<String>(
          'auth', jsonEncode(AuthMapper.toJson(authResponse)));

      return authResponse;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  Future<void> logout() async {
    try {
      final auth = await _localRepository.getValue<String>('auth');

      if (auth != null) {
        final authMap = jsonDecode(auth);
        final authFromLocalStorage = AuthMapper.fromJson(authMap);

        final authDb =
            AuthMapper.mapAuthEntityToAuthInput(authFromLocalStorage);
        await _authRepository.closeSession(authDb);
        await _localRepository.removeKey('auth');
      }
    } on AuthException catch (e) {
      throw AuthException('Error while clossing session ${e.message}');
    }
  }

  Future<void> saveAuthLocally(Auth auth) async {
    await _localRepository.setKeyValue<String>(
        'auth', jsonEncode(AuthMapper.toJson(auth)));
  }
}
