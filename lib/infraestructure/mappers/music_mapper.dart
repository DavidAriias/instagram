import 'package:instagram/domain/entities/entities.dart';
import 'package:instagram/infraestructure/models/models.dart';

class MusicMapper {
  static Song mapSearchSongByNameToSongEntity(SongNode search) => Song(
      id: search.uri,
      imagesUrl: search.imagesAlbum.map((image) => image.url).toList(),
      name: search.songName,
      artist: search.artistName,
      duration: search.duration,
      previewUrl: search.previewUrl,
      album: search.albumName);
}
