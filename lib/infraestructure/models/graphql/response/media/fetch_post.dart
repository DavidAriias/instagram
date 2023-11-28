import '../../../models.dart';

class FetchPostResponse {
    final PostsResponse userProfile;

    FetchPostResponse({
        required this.userProfile,
    });

    factory FetchPostResponse.fromJson(Map<String, dynamic> json) => FetchPostResponse(
        userProfile: PostsResponse.fromJson(json["userProfile"]),
    );
}

class PostsResponse {
    final Posts posts;

    PostsResponse({
        required this.posts,
    });

    factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        posts: Posts.fromJson(json["posts"]),
    );

 }

class Posts {
    final PageInfo pageInfo;
    final List<PostsNode> nodes;

    Posts({
        required this.pageInfo,
        required this.nodes,
    });

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        nodes: List<PostsNode>.from(json["nodes"].map((x) => PostsNode.fromJson(x))),
    );

}

class PostsNode {
    final dynamic song; //TODO: REFACTORIZAR EL TIPO DE DATO
    final String? imageProfile;
    final String postId;
    final List<String> images;
    final String? caption;
    final DateTime datePublication;
    final int likes;
    final Comments? comments;
    final List<String>? hashtags;

    PostsNode({
        required this.song,
        required this.imageProfile,
        required this.postId,
        required this.images,
        required this.caption,
        required this.datePublication,
        required this.likes,
        required this.comments,
        required this.hashtags,
    });

    factory PostsNode.fromJson(Map<String, dynamic> json) => PostsNode(
        song: json["song"],
        imageProfile: json["imageProfile"],
        postId: json["postId"],
        images: List<String>.from(json["images"].map((x) => x)),
        caption: json["caption"],
        datePublication: DateTime.parse(json["datePublication"]),
        likes: json["likes"],
        comments: (json["comments"] != null) ?  Comments.fromJson(json["comments"]) : null,
      hashtags: (json["hashtags"] != null) ? List<String>.from(json["hashtags"].map((x) => x)) : null,

    );

}


