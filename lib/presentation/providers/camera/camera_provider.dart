import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/domain/entities/entities.dart';

final cameraProvider = StateNotifierProvider<CameraNotifier, Media?>((ref) {
  return CameraNotifier(cameraUseCase);
});

class CameraNotifier extends StateNotifier<Media?> {
  final CameraUseCase _cameraUseCase;
  CameraNotifier(this._cameraUseCase) : super(null);

  Future<void> selectPhoto() async {
    state = await _cameraUseCase.selectPhoto();
  }

  Future<void> takePhoto() async {
    state = await _cameraUseCase.takePhoto();
  }

  
}
