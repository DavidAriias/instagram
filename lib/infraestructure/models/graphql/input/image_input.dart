import "package:http/http.dart" show MultipartFile;

class ImageInput {
  final String imagePath;
  final String userId;
  final String accessToken;

  ImageInput(this.imagePath, this.userId, this.accessToken);

  Future<Map<String, dynamic>> toJson() async {
    final image = imagePath.split('/').last;
    return {
      "image": await MultipartFile.fromPath('file', image),
      "userId": userId
    };
  }
}
