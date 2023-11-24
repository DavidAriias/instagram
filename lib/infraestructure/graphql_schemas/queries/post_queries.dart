class PostQueries {
  static String fetchPosts = r'''
query GetUserProfile($userId: UUID!) {
  userProfile(userId: $userId) {
    posts(first: 9) {
      pageInfo {
        hasNextPage
        endCursor
      }
      nodes {
        ...PostNodeFragment
      }
    }
  }
}
''';
}
