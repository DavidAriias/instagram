class CommentsNode {
    final String userId;
    final String text;
    final DateTime date;
    final Comments? replies;
    final String? replyId;

    CommentsNode({
        required this.userId,
        required this.text,
        required this.date,
        this.replies,
        this.replyId,
    });

    factory CommentsNode.fromJson(Map<String, dynamic> json) => CommentsNode(
        userId: json["userId"],
        text: json["text"],
        date: DateTime.parse(json["date"]),
        replies: json["replies"] == null ? null : Comments.fromJson(json["replies"]),
        replyId: json["replyId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "text": text,
        "date": date.toIso8601String(),
        "replies": replies?.toJson(),
        "replyId": replyId,
    };
}

class Comments {
    final List<CommentsNode> nodes;

    Comments({
        required this.nodes,
    });

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        nodes: List<CommentsNode>.from(json["nodes"].map((x) => CommentsNode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}