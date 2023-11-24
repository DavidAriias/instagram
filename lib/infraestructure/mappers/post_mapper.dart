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
    );
}
