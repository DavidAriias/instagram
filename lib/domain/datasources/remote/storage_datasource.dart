import 'dart:io';

abstract class StorageDatasource {
 Future<List<String>> uploadImages(List<File> images, String userId);
  Future<void> deleteImage(String userId, String imageName);

  Future<List<String>> uploadVideo(File video, String userId, String videoName);
  Future<void> deleteVideo(String userId, String videoName);
}
