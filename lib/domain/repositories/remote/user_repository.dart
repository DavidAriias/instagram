import 'package:instagram/infraestructure/models/models.dart';

import '../../entities/entities.dart';

abstract class UserRepository {
  Future<User> getUser(UserInput input);
  Future<List<User>> getFollowers(UserInput input);
  Future<List<User>> getFollowing(UserInput input);
  Future<List<User>> getFollowersSuggestions(UserInput input);
  Future<List<User>> searchUsers(SearchInput input);
  Future<String> changePassword(PasswordInput input);
  Future<String> changeVerified(UserInput input);
  Future<String> changeImageProfile(ImageInput input);
}
