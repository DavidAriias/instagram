import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/infraestructure/models/models.dart';

import '../../../config/dependenciesInjection/instances_container.dart';
import '../../../domain/entities/entities.dart';

final listMusicProvider = StateNotifierProvider<ListMusicNotifier, List<Song>>((ref) {
  return ListMusicNotifier(musicUseCase, authUseCase);
});

class ListMusicNotifier extends StateNotifier<List<Song>> {
  final MusicUseCase _musicUseCase;
  final AuthUseCase _authUseCase;
  bool isLoading = false;

  ListMusicNotifier(this._musicUseCase, this._authUseCase) : super([]);

  Future<void> searchSongs(String search) async {
    //TODO : HACER MAPPERS PARA CADA INPUT

    if (isLoading) return;

    isLoading = true;

    if (search.isEmpty) {
      onResetSongs();
      return;
    } else {
      final auth = await _authUseCase.getLocalAuth();
      final request = SongInput(accessToken: auth!.token, songName: search);
      final songs = await _musicUseCase.searchSongsByName(request);

      if (songs.isEmpty) {
        state = [];
      } else {
        state = [...songs];
      }
    }

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  void onResetSongs() {
    state = List.of(state)..clear();
  }
  
  
}
