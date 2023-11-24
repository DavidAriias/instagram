import '../../../models.dart';

class FollowingResponse {
    final FollowersFromUser followersFromUser;

    FollowingResponse({
        required this.followersFromUser,
    });

    factory FollowingResponse.fromJson(Map<String, dynamic> json) => FollowingResponse(
        followersFromUser: FollowersFromUser.fromJson(json["usersFollowedByOthers"]),
    );
}
