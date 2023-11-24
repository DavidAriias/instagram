class SearchResponse {
    final SearchUsers searchUsers;

    SearchResponse({
        required this.searchUsers,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        searchUsers: SearchUsers.fromJson(json["searchUsers"]),
    );

    Map<String, dynamic> toJson() => {
        "searchUsers": searchUsers.toJson(),
    };
}

class SearchUsers {
    final List<SearchNode> nodes;

    SearchUsers({
        required this.nodes,
    });

    factory SearchUsers.fromJson(Map<String, dynamic> json) => SearchUsers(
        nodes: List<SearchNode>.from(json["nodes"].map((x) => SearchNode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}

class SearchNode {
    final String userId;
    final String username;
    final String? name;
    final String? imageProfile;

    SearchNode({
        required this.userId,
        required this.username,
        required this.name,
        required this.imageProfile,
    });

    factory SearchNode.fromJson(Map<String, dynamic> json) => SearchNode(
        userId: json["userId"],
        username: json["username"],
        name: json["name"],
        imageProfile: json["imageProfile"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "name": name,
        "imageProfile": imageProfile,
    };
}
