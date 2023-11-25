import '../../../infraestructure/models/models.dart';
import '../../entities/entities.dart';

abstract class MusicRepository {
  Future<List<Song>> getSongsByUser(SongInput input);
}