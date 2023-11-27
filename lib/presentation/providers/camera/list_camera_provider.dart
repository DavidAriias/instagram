import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/presentation/providers/providers.dart';

import '../../../app/useCases/uses_cases.dart';
import '../../../domain/entities/entities.dart';

final listCameraProvider =
    StateNotifierProvider<ListCameraNotifier, List<Media>>((ref) {
  final postChangeMediaCallback =
      ref.watch(postProvider.notifier).onChangeMedia;
  return ListCameraNotifier(cameraUseCase, postChangeMediaCallback);
});

class ListCameraNotifier extends StateNotifier<List<Media>> {
  final CameraUseCase _cameraUseCase;
  final void Function(List<Media>) postChangeMediaCallback;
  ListCameraNotifier(this._cameraUseCase, this.postChangeMediaCallback)
      : super([]);

  Future<void> selectMedia() async {
    final media = await _cameraUseCase.selectMultipleMedia();
    state = [...state, ...media];
  }

  void onRemove(int index) {
    if (index >= 0 && index < state.length) {
      state = List.from(state)..removeAt(index);
    }
  }

  void onInsert(int index, Media element) {
    if (index >= 0 && index <= state.length) {
      state = List.from(state)..insert(index, element);
    }
  }

  void onReset() {
    state = List.from(state)..clear();
  }

  void onSend() {
    postChangeMediaCallback(state);
  }
  
}
