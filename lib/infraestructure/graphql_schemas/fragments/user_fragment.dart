class UserFragments {
  static String followerFragment = r'''
fragment FollowerNodeFragment on FollowerType {
  id
  username
  imageProfile
}
''';

static String searchUserFragment = r'''
fragment SearchFragment on SearchType {
  userId
  username
  name
  imageProfile
}
''';
}
