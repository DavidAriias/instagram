import 'dart:io';

import 'package:instagram/domain/datasources/datasource.dart';
import 'package:instagram/domain/repositories/repositories.dart';

class StorageRepositoryImpl extends StorageRepository {
  final StorageDatasource _storageDatasource;

  StorageRepositoryImpl(this._storageDatasource);

  @override
  Future<void> deleteImage(String userId, String imageName) {
    return _storageDatasource.deleteImage(userId, imageName);
  }

  @override
  Future<void> deleteVideo(String userId, String videoName) {
    return _storageDatasource.deleteVideo(userId, videoName);
  }

  @override
  Future<List<String>> uploadImages(List<File> images, String userId) {
    return _storageDatasource.uploadImages(images, userId);
  }

  @override
  Future<List<String>> uploadVideo(
      File video, String userId, String videoName) {
    return _storageDatasource.uploadVideo(video, userId, videoName);
  }
}
