import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/config/config.dart';
import 'package:instagram/domain/entities/entities.dart';

class MediaMapper {
  static Future<Media> mapImageToPhotoEntity(XFile image) async {
    final File file = File(image.path);
    final Uint8List bytes = await file.readAsBytes();
    final img.Image? imageFile = img.decodeImage(bytes);

    if (imageFile != null) {
      return Media(
        path: image.path,
        width: imageFile.width,
        height: imageFile.height,
        isImage: MediaHelper.isImage(image.path)
      );
    } else {
      // Manejo de errores, por ejemplo, devolver una instancia de Media con valores predeterminados o lanzar una excepción
      return Media(
        path: image.path,
        width: 0,
        height: 0,
        isImage: MediaHelper.isImage(image.path)
      );
    }
  }
}
