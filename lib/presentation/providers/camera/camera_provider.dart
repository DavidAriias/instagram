import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';

final cameraProvider = StateNotifierProvider<CameraNotifier, String?>((ref) {
  return CameraNotifier(cameraUseCase);
});

class CameraNotifier extends StateNotifier<String?> {
  final CameraUseCase _cameraUseCase;
  CameraNotifier(this._cameraUseCase) : super('');

  Future<void> selectPhoto() async {
    state = await _cameraUseCase.selectPhoto();
  }

  Future<void> takePhoto() async {
    state = await _cameraUseCase.takePhoto();
  }

  
}
