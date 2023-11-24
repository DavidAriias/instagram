import 'package:instagram/domain/datasources/datasource.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../models/models.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<User> getUser(UserInput input) {
    return _dataSource.getUser(input);
  }

  @override
  Future<List<User>> getFollowers(UserInput input) {
    return _dataSource.getFollowers(input);
  }

  @override
  Future<List<User>> getFollowing(UserInput input) {
    return _dataSource.getFollowing(input);
  }

  @override
  Future<List<User>> getFollowersSuggestions(UserInput input) {
    return _dataSource.getFollowersSuggestions(input);
  }

  @override
  Future<List<User>> searchUsers(SearchInput input) {
    return _dataSource.searchUsers(input);
  }

  @override
  Future<String> changePassword(PasswordInput input) {
    return _dataSource.changePassword(input);
  }

  @override
  Future<String> changeVerified(UserInput input) {
    return _dataSource.changeVerified(input);
  }

  @override
  Future<String> changeImageProfile(ImageInput input) {
    return _dataSource.changeImageProfile(input);
  }
}
