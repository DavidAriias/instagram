class User {
  final String id;
  final String? name;
  final String username;
  final String birthday;
  final String? bio;
  final String? profilePictureUrl;
  final String? pronoun;
  final int followersCount;
  final int followingCount;
  final bool isVerificated;
  final bool isPrivate;
  final int postCount;

  User(
      {this.id = '',
      this.name,
      this.username = '',
      this.birthday = '',
      this.bio,
      this.profilePictureUrl,
      this.pronoun,
      this.followersCount = 0,
      this.followingCount = 0,
      this.postCount = 0,
      this.isVerificated = false,
      this.isPrivate = false});
}
