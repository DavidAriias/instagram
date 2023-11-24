import 'dart:convert';

import 'package:instagram/domain/repositories/repositories.dart';
import 'package:instagram/infraestructure/errors/auth_error.dart';
import '../../../domain/entities/entities.dart';
import '../../../infraestructure/mappers/auth_mapper.dart';

class AuthUseCase {
  final LocalRepository _localRepository;

  AuthUseCase(this._localRepository);
  
  Future<Auth?> getLocalAuth() async {
    final auth = await _localRepository.getValue<String>('auth');
    if (auth == null) return null;

    try {
      final authMap = jsonDecode(auth);
      return AuthMapper.fromJson(authMap);
    } catch (e) {
      throw AuthException("It can't get auth locally");
    }
  }

  Future<void> saveAuthLocally(Auth auth) async {
    await _localRepository.setKeyValue<String>(
        'auth', jsonEncode(AuthMapper.toJson(auth)));
  }

  Future<void> removeAuthLocally() async {
    await _localRepository.removeKey('auth');
  }
}
