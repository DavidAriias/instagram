
abstract class CameraService {
  Future<String?> takePhoto();
  Future<String?> selectPhoto();
  Future<List<String>> selectMultipleMedia();
  Future<String?> takeVideo();
}
