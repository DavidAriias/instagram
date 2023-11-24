import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';

import '../../../app/useCases/uses_cases.dart';

final listCameraProvider =
    StateNotifierProvider<ListCameraProvider, List<String>>((ref) {
  return ListCameraProvider(cameraUseCase);
});

class ListCameraProvider extends StateNotifier<List<String>> {
  final CameraUseCase _cameraUseCase;
  ListCameraProvider(this._cameraUseCase) : super([]);

  Future<void> selectMedia() async {
    final media = await _cameraUseCase.selectMultipleMedia();
    state = [...state, ...media];
  }

  void onRemove(int index) {
    if (index >= 0 && index < state.length) {
      state = List.from(state)..removeAt(index);
    }
  }

  void onInsert(int index, String element) {
    if (index >= 0 && index <= state.length) {
      state = List.from(state)..insert(index, element);
    }
  }

  void onReset() {
    state = List.from(state)..clear();
  }
}
