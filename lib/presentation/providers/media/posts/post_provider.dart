import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/presentation/providers/providers.dart';
import '../../../../domain/entities/entities.dart';

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final userData = ref.watch(mainUserProvider);
  return PostNotifier(userData);
});

class PostNotifier extends StateNotifier<PostState> {
  final User _userData;
  PostNotifier(this._userData) : super(PostState());

  Future<void> onCreatePost() async {
    state = state.copyWith(userId: _userData.id, username: _userData.username);
    print(state.toString());
  }

  void onResetSong() {
    state = state.resetSong();
  }

  void onResetLocation() {
    state = state.resetLocation();
  }

  void onChangeSong(Song value) {
    state = state.copyWith(song: value);
  }

  void onChangeLocation(LocationEntity value) {
    state = state.copyWith(location: value);
  }

  void onChangeMedia(List<Media> value) {
    state = state.copyWith(media: value);
  }

  void onChangeCaption(String value) {
    state = state.copyWith(caption: value);
  }
}

class PostState {
  final String caption;
  final LocationEntity? location;
  final Song? song;
  final String username;
  final String userId;
  final List<Media> media;

  PostState({
    this.caption = '',
    this.username = '',
    this.userId = '',
    this.location,
    this.song,
    List<Media>? media,
  }) : media = media ?? [];

  PostState copyWith(
          {String? caption,
          LocationEntity? location,
          Song? song,
          String? username,
          String? userId,
          List<Media>? media}) =>
      PostState(
          caption: caption ?? this.caption,
          location: location ?? this.location,
          song: song ?? this.song,
          username: username ?? this.username,
          userId: userId ?? this.userId,
          media: media ?? this.media);

  PostState resetSong() {
    return PostState(
      caption: caption,
      location: location,
      username: username,
      userId: userId,
      media: media,
    );
  }

  PostState resetLocation() {
    return PostState(
      caption: caption,
      song: song,
      username: username,
      userId: userId,
      media: media,
    );
  }

  @override
  String toString() {
    return '''
      caption: $caption,
      LocationEntity: $location,
      Song: $song,
      username: $username,
      userId: $userId,
      media: $media
    ''';
  }
}
