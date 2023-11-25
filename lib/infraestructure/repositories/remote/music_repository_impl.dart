import 'package:instagram/domain/entities/song.dart';

import 'package:instagram/infraestructure/models/graphql/input/song_input.dart';

import '../../../domain/datasources/datasource.dart';
import '../../../domain/repositories/repositories.dart';

class MusicRepositoryImpl extends MusicRepository {
  final MusicDataSource _musicDataSource;

  MusicRepositoryImpl(this._musicDataSource);
  @override
  Future<List<Song>> getSongsByUser(SongInput input) {
    return _musicDataSource.getSongsByUser(input);
  }
}
