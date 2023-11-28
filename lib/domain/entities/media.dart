import 'dart:io';

import 'package:instagram/domain/entities/entities.dart';

class Media {
  final String path;
  final int width;
  final int height;
  final LocationEntity? location;
  final bool isImage;
  final File? file;

  Media(
      {required this.path,
      required this.width,
      required this.height,
      this.location,
      required this.isImage,
      this.file
      });
}
