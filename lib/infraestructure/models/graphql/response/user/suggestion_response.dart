import '../../../models.dart';

class SuggestionsResponse {
    final FollowersFromUser followersFromUser;

    SuggestionsResponse({
        required this.followersFromUser,
    });

    factory SuggestionsResponse.fromJson(Map<String, dynamic> json) => SuggestionsResponse(
        followersFromUser: FollowersFromUser.fromJson(json["suggestionsFollowers"]),
    );
}
