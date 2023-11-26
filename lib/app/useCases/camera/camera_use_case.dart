import 'package:instagram/infraestructure/services/services.dart';

import '../../../domain/entities/entities.dart';

class CameraUseCase {
  final CameraService _cameraService;

  CameraUseCase(this._cameraService);

  Future<Media?> selectPhoto() async {
    return _cameraService.selectPhoto();
  }

  Future<List<Media>> selectMultipleMedia() async {
    return await _cameraService.selectMultipleMedia();
  }

  Future<Media?> takePhoto() async {
    return _cameraService.takePhoto();
  }
}
