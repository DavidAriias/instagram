import 'package:graphql/client.dart';
import 'package:instagram/infraestructure/errors/user_error.dart';
import 'package:instagram/infraestructure/graphql_schemas/graphql.dart';

import '../../../domain/datasources/datasource.dart';
import '../../../domain/entities/entities.dart';
import '../../graphql_schemas/graphql_client.dart';
import '../../mappers/user_mapper.dart';
import '../../models/models.dart';

class UserGraphQlDatasourceImpl extends UserDataSource {
  @override
  Future<User> getUser(UserInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document:
            gql(MediaSubtypeFragment.linkFragment + UserQueries.getProfile),
        variables: {'userId': input.userId});

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }

      final response = UserProfileResponse.fromJson(result.data!);
      return UserMapper.mapUserProfileToUserEntity(response.userProfile);
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<List<User>> getFollowers(UserInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document:
            gql(UserFragments.followerFragment + UserQueries.fetchFollowers),
        variables: {'first': 10, 'userId': input.userId, 'afterCursor': null});

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }

      final response = FollowersResponse.fromJson(result.data!);
      final users = response.followersFromUser.nodes;

      return users.map(UserMapper.mapFollowerNodeToUserEntity).toList();
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<List<User>> getFollowing(UserInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document:
            gql(UserFragments.followerFragment + UserQueries.fetchFollowing),
        variables: {'first': 10, 'userId': input.userId, 'afterCursor': null});

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }
      final response = FollowingResponse.fromJson(result.data!);
      final users = response.followersFromUser.nodes;

      return users.map(UserMapper.mapFollowerNodeToUserEntity).toList();
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<List<User>> getFollowersSuggestions(UserInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document: gql(UserFragments.followerFragment +
            UserQueries.fetchFollowersSuggestions),
        variables: {'first': 10, 'userId': input.userId, 'afterCursor': null});

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }
      final response = SuggestionsResponse.fromJson(result.data!);
      final users = response.followersFromUser.nodes;

      return users.map(UserMapper.mapFollowerNodeToUserEntity).toList();
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<List<User>> searchUsers(SearchInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document:
            gql(UserFragments.searchUserFragment + UserQueries.searchUsers),
        variables: {'first': 10, 'input': input.search});

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }

      final response = SearchResponse.fromJson(result.data!);
      final search = response.searchUsers.nodes;

      return search.map(UserMapper.mapSearchNodeToUserEntity).toList();
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<String> changePassword(PasswordInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = MutationOptions(
        document: gql(UserMutations.changePassword),
        variables: {'input': input.toJson()});

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }

      final response = UpdatePasswordResponse.fromJson(result.data!);
      final statusCode = response.updatePassword.statusCode;
      final message = response.updatePassword.message;

      if (statusCode != 'NO_CONTENT') {
        throw UserException(message);
      }
      return message;
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<String> changeVerified(UserInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = MutationOptions(
        document: gql(UserMutations.changeVerified),
        variables: {
          'input': {
            'userId' : input.userId
          }
        });

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }

      final response = UpdatePasswordResponse.fromJson(result.data!);
      final statusCode = response.updatePassword.statusCode;
      final message = response.updatePassword.message;

      if (statusCode != 'NO_CONTENT') {
        throw UserException(message);
      }
      return message;
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }

  @override
  Future<String> changeImageProfile(ImageInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = MutationOptions(
        document: gql(UserMutations.changeImageProfile),
        variables: {'input': await input.toJson()});

    try {
      final QueryResult result = await client.mutate(options);
      if (result.hasException) {
        throw UserException(result.exception!.graphqlErrors.first.message);
      }

      final response = UpdatePasswordResponse.fromJson(result.data!);
      final statusCode = response.updatePassword.statusCode;
      final message = response.updatePassword.message;

      if (statusCode != 'NO_CONTENT') {
        throw UserException(message);
      }
      return message;
    } on UserException catch (e) {
      throw UserException(e.message);
    }
  }
}
