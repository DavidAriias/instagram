import 'package:instagram/infraestructure/models/models.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/repositories/repositories.dart';

class MusicUseCase {
  final MusicRepository _musicRepository;

  MusicUseCase(this._musicRepository);

  Future<List<Song>> searchSongsByName(SongInput input) {
    return _musicRepository.getSongsByUser(input);
  }
}
