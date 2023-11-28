import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram/domain/datasources/datasource.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageDatasourceImpl implements StorageDatasource {
  final storage = FirebaseStorage.instance;

  @override
  Future<void> deleteImage(String userId, String imageName) {
    // TODO: implement deleteImage
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVideo(String userId, String videoName) {
    // TODO: implement deleteVideo
    throw UnimplementedError();
  }

  @override
  Future<List<String>> uploadImages(List<File> images, String userId) async {
    String storagePath = 'posts/$userId/';

    return Future.wait(images.map((image) async {
      final filename = image.path.split('/').last;
      final ref = storage.ref().child('$storagePath$filename');

      await ref.putFile(image);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    }).toList());
  }

  @override
  Future<List<String>> uploadVideo(
      File video, String userId, String videoName) {
    // TODO: implement uploadVideo
    throw UnimplementedError();
  }
}
