import '../../../infraestructure/models/models.dart';
import '../../entities/entities.dart';

abstract class MusicDataSource {
  Future<List<Song>> getSongsByUser(SongInput input);
}
