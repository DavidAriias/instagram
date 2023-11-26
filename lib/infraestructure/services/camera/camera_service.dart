
import '../../../domain/entities/entities.dart';

abstract class CameraService {
  Future<Media?> takePhoto();
  Future<Media?> selectPhoto();
  Future<List<Media>> selectMultipleMedia();
  Future<String?> takeVideo();
}
