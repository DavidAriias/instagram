import 'package:instagram/infraestructure/models/models.dart';

class CreatePostInput {
  final String? caption;
  final LocationInput? location;
  final List<String>? tags;
  final String userId;
  final String username;
  final SongMediaInput? music;
  final List<String> medias;
  final List<String>? mentions;
  final String accessToken;

  CreatePostInput({
    this.mentions,
    this.caption,
    this.location,
    this.tags,
    required this.userId,
    required this.username,
    this.music,
    required this.medias,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
  return {
    "input": {
      "post": {
        "username": username,
        "userId": userId,
        "caption": caption,
        "music": music,
        "tags": tags,
        "location": location,
        "mentions": mentions,
        "media": medias,
      },
    },
  };
}


}
