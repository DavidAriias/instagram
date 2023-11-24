import '../../../models.dart';

class FetchPostResponse {
    final PostsResponse userProfile;

    FetchPostResponse({
        required this.userProfile,
    });

    factory FetchPostResponse.fromJson(Map<String, dynamic> json) => FetchPostResponse(
        userProfile: PostsResponse.fromJson(json["userProfile"]),
    );

    Map<String, dynamic> toJson() => {
        "userProfile": userProfile.toJson(),
    };
}

class PostsResponse {
    final Posts posts;

    PostsResponse({
        required this.posts,
    });

    factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        posts: Posts.fromJson(json["posts"]),
    );

    Map<String, dynamic> toJson() => {
        "posts": posts.toJson(),
    };
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

    Map<String, dynamic> toJson() => {
        "pageInfo": pageInfo.toJson(),
        "nodes": List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}

class PostsNode {
    final dynamic song; //TODO: REFACTORIZAR EL TIPO DE DATO
    final String? imageProfile;
    final String postId;
    final List<String> images;
    final String caption;
    final DateTime datePublication;
    final int likes;
    final Comments comments;
    final List<String> hashtags;

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
        comments: Comments.fromJson(json["comments"]),
        hashtags: List<String>.from(json["hashtags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "song": song,
        "imageProfile": imageProfile,
        "postId": postId,
        "images": List<String>.from(images.map((x) => x)),
        "caption": caption,
        "datePublication": datePublication.toIso8601String(),
        "likes": likes,
        "comments": comments.toJson(),
        "hashtags": List<String>.from(hashtags.map((x) => x)),
    };
}


