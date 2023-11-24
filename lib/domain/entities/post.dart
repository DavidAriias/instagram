class Post {
  final String id;
  final String caption;
  final DateTime datePublication;
  final List<String> mediaUrls;
  final int likes;
  final String? imageProfile;

  Post(
      {required this.id,
      required this.caption,
      required this.datePublication,
      required this.mediaUrls,
      required this.likes,
      this.imageProfile
      });
}
