import 'package:image_picker/image_picker.dart';

import 'package:instagram/infraestructure/mappers/photo_mapper.dart';

import '../../../domain/entities/entities.dart';
import 'camera_service.dart';

class CameraServiceImpl extends CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future<List<Media>> selectMultipleMedia() async {
    final List<XFile> medias =
        await _imagePicker.pickMultipleMedia(imageQuality: 100);

    return await Future.wait(
      medias.map(
        (XFile media) async {
          return await MediaMapper.mapImageToPhotoEntity(media);
        },
      ),
    );
  }

  @override
  Future<Media?> selectPhoto() async {
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    if (image == null) return null;

    return MediaMapper.mapImageToPhotoEntity(image);
  }

  @override
  Future<Media?> takePhoto() async {
    final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    if (photo == null) return null;

    return MediaMapper.mapImageToPhotoEntity(photo);
  }

  @override
  Future<String?> takeVideo() async {
    final XFile? cameraVideo =
        await _imagePicker.pickVideo(source: ImageSource.camera);

    if (cameraVideo == null) return null;

    return cameraVideo.path;
  }
}
