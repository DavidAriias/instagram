import '../../../../domain/entities/entities.dart';

class PostData{
  final String? caption;
  final LocationEntity? location;
  final String userId;
  final String username;
  final Song? song;
  final List<String> media;
  final String accessToken;
  

  PostData({required this.caption, required this.location, required this.userId, required this.username, required this.song, required this.media, required this.accessToken});
}
