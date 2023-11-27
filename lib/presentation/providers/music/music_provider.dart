import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/entities.dart';
import '../providers.dart';

final musicProvider = StateNotifierProvider<MusicNotifier, Song>((ref) {
  final postOnChangeSongCallback =
      ref.watch(postProvider.notifier).onChangeSong;
  return MusicNotifier(postOnChangeSongCallback);
});

class MusicNotifier extends StateNotifier<Song> {
  final void Function(Song) _postOnChangeSongCallback;
  MusicNotifier(this._postOnChangeSongCallback) : super(Song());

  void onSelectedSong(Song value) {
    _postOnChangeSongCallback(value);
  }
}
