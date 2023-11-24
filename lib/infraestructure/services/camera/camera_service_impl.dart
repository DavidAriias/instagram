import 'package:image_picker/image_picker.dart';
import 'camera_service.dart';

class CameraServiceImpl extends CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future<List<String>> selectMultipleMedia() async {
    final List<XFile> medias =
        await _imagePicker.pickMultipleMedia(imageQuality: 100);

    return medias.map((xfile) => xfile.path).toList();
  }

  @override
  Future<String?> selectPhoto() async {
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    if (image == null) return null;

    return image.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    if (photo == null) return null;

    return photo.path;
  }

  @override
  Future<String?> takeVideo() async {
    final XFile? cameraVideo =
        await _imagePicker.pickVideo(source: ImageSource.camera);

    if (cameraVideo == null) return null;

    return cameraVideo.path;
  }
}
