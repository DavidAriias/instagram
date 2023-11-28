import 'package:instagram/app/models/models.dart';
import 'package:instagram/domain/entities/entities.dart';
import 'package:instagram/infraestructure/models/models.dart';
import 'package:instagram/presentation/enums/enums.dart';

class PostMapper {
  static CreatePostInput mapPostDataToCreatePostInput(
          PostData data) =>
      CreatePostInput(
          caption: data.caption,
          location: (data.location != null)
              ? mapLocationEntityToLocationInput(data.location!)
              : null,
          userId: data.userId,
          username: data.username,
          music: (data.song != null)
              ? mapSongEntityToSongMediaInput(data.song!)
              : null,
          medias: data.media,
          accessToken: data.accessToken);

  static LocationInput mapLocationEntityToLocationInput(
          LocationEntity location) =>
      LocationInput(
          latitude: location.latitude!, longitude: location.longitude!);
  static SongMediaInput mapSongEntityToSongMediaInput(Song song) =>
      SongMediaInput(
          artist: song.artist,
          title: song.name,
          totalDuration: song.duration,
          url: song.previewUrl,
          durationSelection: mapSelectionToDurationSelectionInput());
  static DurationSelectionInput mapSelectionToDurationSelectionInput() =>
      DurationSelectionInput(begin: '0:00', end: '0:10');
  //TODO: CAMBIAR EVENTUALMENTE PARA DETERMIANR TIPO DE MEDIA
  static MediaInput mapStringMediaToMediaInput(String media) =>
      MediaInput(mediaType: MediaTypePresentation.image, path: media);
}
