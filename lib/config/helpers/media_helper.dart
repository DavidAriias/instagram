class MediaHelper {
  static bool isImage(String path) {
    final extension = path.split('.').last.toLowerCase();
    return extension == 'jpg' || extension == 'png';
  }
}
