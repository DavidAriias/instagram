class UserQueries {
  static String getProfile = r'''
query GetUserProfile($userId :UUID!) {
  userProfile(userId: $userId) {
    id
    name
    username
    isverificated
    isPrivate
    imageProfile
    description
    pronoun
    birthday
    followersCount
    followingCount
    postsNumber
    link {
      ...LinkFragment
    }
  }
}
''';

  static String fetchFollowers = r'''
query GetFollowers($first: Int!, $userId: UUID!, $afterCursor: String){
    followersFromUser(first: $first, userId: $userId, after: $afterCursor) {
    # Información de paginación
    pageInfo {
      hasNextPage
      endCursor
    }
    nodes {
      ...FollowerNodeFragment
    }
  }
}
''';

  static String fetchFollowersSuggestions = r'''
query GetFollowerSuggestions($first: Int!, $userId: UUID!, $afterCursor: String) {
  suggestionsFollowers(first: $first, userId: $userId, after: $afterCursor) {
    # Información de paginación
    pageInfo {
      hasNextPage
      endCursor
    }
    nodes {
      ...FollowerNodeFragment
    }
  }
}
''';
  static String fetchFollowing = r'''
query GetFollowerSuggestions($first: Int!, $userId: UUID!, $afterCursor: String) {
  usersFollowedByOthers(first: $first, userId: $userId, after: $afterCursor) {
    # Información de paginación
    pageInfo {
      hasNextPage
      endCursor
    }
    nodes {
      ...FollowerNodeFragment
    }
  }
}
''';

  static String searchUsers = r'''
query SearchUsersQuery($first: Int, $input: String!) {
  searchUsers(first: $first, input: $input) {
    nodes {
      ...SearchFragment
    }
  }
}
''';
}
