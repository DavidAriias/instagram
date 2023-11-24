import 'package:instagram/infraestructure/models/models.dart';

import '../../domain/entities/entities.dart';

class UserMapper {
  static User mapUserProfileToUserEntity(UserProfile response) => User(
      id: response.id,
      name: response.name,
      username: response.username,
      birthday: response.birthday.toString(),
      bio: response.description,
      profilePictureUrl: response.imageProfile,
      followersCount: response.followersCount,
      followingCount: response.followingCount,
      pronoun: response.pronoun,
      isVerificated: response.isverificated,
      isPrivate: response.isPrivate,
      postCount: response.postsNumber);

  static UserInput mapAuthEntityToUserInput(Auth auth) =>
      UserInput(userId: auth.userId, accessToken: auth.token);

  static User mapFollowerNodeToUserEntity(FollowersNode follower) => User(
      id: follower.id,
      profilePictureUrl: follower.imageProfile,
      username: follower.username);

  static User mapSearchNodeToUserEntity(SearchNode search) => User(
    id: search.userId,
    profilePictureUrl: search.imageProfile,
    name: search.name,
    username: search.username
  );
}
