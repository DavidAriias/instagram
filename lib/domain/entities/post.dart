import 'entities.dart';

class Post {
  final String id;
  final String? caption;
  final DateTime datePublication;
  final List<String> mediaUrls;
  final int likes;
  final String? imageProfile;
  final List<Comment>? comments;

  Post(
      {required this.id,
      required this.caption,
      required this.datePublication,
      required this.mediaUrls,
      required this.likes,
      this.imageProfile,
      required this.comments
      });
}
