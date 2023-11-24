import 'package:instagram/infraestructure/services/services.dart';

class CameraUseCase {
  final CameraService _cameraService;

  CameraUseCase(this._cameraService);

  Future<String?> selectPhoto() async {
    return await _cameraService.selectPhoto();
  }

  Future<List<String>> selectMultipleMedia() async {
    return await _cameraService.selectMultipleMedia();
  }

  Future<String?> takePhoto() async {
    return await _cameraService.takePhoto();
  }
}
