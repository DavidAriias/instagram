import '../../../models.dart';

class FollowersResponse {
    final FollowersFromUser followersFromUser;

    FollowersResponse({
        required this.followersFromUser,
    });

    factory FollowersResponse.fromJson(Map<String, dynamic> json) => FollowersResponse(
        followersFromUser: FollowersFromUser.fromJson(json["followersFromUser"]),
    );
}

class FollowersFromUser {
    final PageInfo pageInfo;
    final List<FollowersNode> nodes;

    FollowersFromUser({
        required this.pageInfo,
        required this.nodes,
    });

    factory FollowersFromUser.fromJson(Map<String, dynamic> json) => FollowersFromUser(
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        nodes: List<FollowersNode>.from(json["nodes"].map((x) => FollowersNode.fromJson(x))),
    );

}

class FollowersNode {
    final String id;
    final String username;
    final String? imageProfile;

    FollowersNode({
        required this.id,
        required this.username,
        required this.imageProfile,
    });

    factory FollowersNode.fromJson(Map<String, dynamic> json) => FollowersNode(
        id: json["id"],
        username: json["username"],
        imageProfile: json["imageProfile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "imageProfile": imageProfile,
    };
}