import 'package:instagram/infraestructure/errors/user_error.dart';
import 'package:instagram/infraestructure/models/models.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infraestructure/mappers/user_mapper.dart';

class UserUseCase {
  final UserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<User> getUserDetails(Auth auth) async {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return await _userRepository.getUser(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<List<User>> getFollowers(Auth auth) async {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return await _userRepository.getFollowers(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<List<User>> getFollowing(Auth auth) async {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return await _userRepository.getFollowing(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<List<User>> getFollowersSuggestions(Auth auth) async {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return await _userRepository.getFollowersSuggestions(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<String> updatePassword(Auth auth, String password) async {
    final request = PasswordInput(
        password: password,
        accessToken: auth.refreshToken,
        userId: auth.userId);

    try {
      return await _userRepository.changePassword(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<String> updateVerified(Auth auth) async {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return await _userRepository.changeVerified(request);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  Future<String> updateImageProfile(Auth auth) async {
    return '';
  }
}
