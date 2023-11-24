class UserProfileResponse {
  final UserProfile userProfile;

  UserProfileResponse({
    required this.userProfile,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        userProfile: UserProfile.fromJson(json["userProfile"]),
      );
  Map<String, dynamic> toJson() => {
        "userProfile": userProfile.toJson(),
      };
}

class UserProfile {
  final String id;
  final String? name;
  final String username;
  final bool isverificated;
  final bool isPrivate;
  final String? imageProfile;
  final String? description;
  final String? pronoun;
  final DateTime birthday;
  final int followersCount;
  final int followingCount;
  final int postsNumber;
  final dynamic link; //TODO: REFACTORIZAR EL TIPO DE DATO PORQUE ES UN MAP

  UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.isverificated,
    required this.isPrivate,
    required this.imageProfile,
    required this.description,
    required this.pronoun,
    required this.birthday,
    required this.followersCount,
    required this.followingCount,
    required this.postsNumber,
    required this.link,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        isverificated: json["isverificated"],
        isPrivate: json["isPrivate"],
        imageProfile: json["imageProfile"],
        description: json["description"],
        pronoun: json["pronoun"],
        birthday: DateTime.parse(json["birthday"]),
        followersCount: json["followersCount"],
        followingCount: json["followingCount"],
        postsNumber: json["postsNumber"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "isverificated": isverificated,
        "isPrivate": isPrivate,
        "imageProfile": imageProfile,
        "description": description,
        "pronoun": pronoun,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "followersCount": followersCount,
        "followingCount": followingCount,
        "postsNumber": postsNumber,
        "link": link,
      };
}
