import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/mappers/media/post/post_mapper.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/config/router/app_router_notifier.dart';
import 'package:instagram/infraestructure/errors/post_error.dart';
import 'package:instagram/presentation/providers/providers.dart';
import '../../../../app/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../enums/enums.dart';

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final userData = ref.read(mainUserProvider);
  return PostNotifier(userData, postUseCase, authUseCase);
});

class PostNotifier extends StateNotifier<PostState> {
  final User _userData;
  final PostUseCase _postUseCase;
  final AuthUseCase _authUseCase;
  PostNotifier(this._userData, this._postUseCase, this._authUseCase)
      : super(PostState());

  Future<void> onCreatePost() async {
    state = state.copyWith(
        userId: _userData.id,
        username: _userData.username,
        status: PostStatus.posting);

    final storageResponse = await _postUseCase.uploadMediaToStorage(
        state.media.map((media) => media.file!).toList(), _userData.id);

    final auth = await _authUseCase.getLocalAuth();

    final data = PostData(
        caption: state.caption,
        location: state.location,
        userId: state.userId,
        username: state.username,
        song: state.song,
        media: storageResponse,
        accessToken: auth!.token);

    try {
      final post = PostMapper.mapPostDataToCreatePostInput(data);
      await _postUseCase.createPost(post);
      state = state.copyWith(status: PostStatus.created);
    } on PostException catch (e) {
      _onErrorPosting(e.message);
    }
  }

  void _onErrorPosting([String? errorMessage]) {
    state =
        state.copyWith(status: PostStatus.error, errorMessage: errorMessage);
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
  final PostStatus status;
  final String errorMessage;

  PostState({
    this.caption = '',
    this.username = '',
    this.userId = '',
    this.location,
    this.song,
    this.status = PostStatus.editing,
    this.errorMessage = '',
    List<Media>? media,
  }) : media = media ?? [];

  PostState copyWith({
    String? caption,
    LocationEntity? location,
    Song? song,
    String? username,
    String? userId,
    List<Media>? media,
    PostStatus? status,
    String? errorMessage,
  }) =>
      PostState(
          caption: caption ?? this.caption,
          location: location ?? this.location,
          song: song ?? this.song,
          username: username ?? this.username,
          userId: userId ?? this.userId,
          media: media ?? this.media,
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage);

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
      media: $media,
      status: $status
    ''';
  }
}
