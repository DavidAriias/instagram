import 'package:instagram/infraestructure/models/models.dart';

import '../../domain/entities/entities.dart';

class PostMapper {
  static Post mapPostNodeToPostEntity(PostsNode postNode) => Post(
      id: postNode.postId,
      caption: postNode.caption,
      datePublication: postNode.datePublication,
      mediaUrls: postNode.images,
      likes: postNode.likes,
      imageProfile: postNode.imageProfile,
      comments: (postNode.comments != null)
          ? postNode.comments!.nodes
              .map((comment) => mapCommentNodeToCommentEntity(comment))
              .toList()
          : null);

  static Comment mapCommentNodeToCommentEntity(CommentsNode comment) =>
      Comment(text: comment.text, userId: comment.userId, date: comment.date);
}
