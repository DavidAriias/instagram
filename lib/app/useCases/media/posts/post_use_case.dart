import 'dart:io';

import 'package:instagram/domain/repositories/remote/post_repository.dart';
import 'package:instagram/infraestructure/errors/post_error.dart';
import 'package:instagram/infraestructure/models/models.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../../infraestructure/mappers/user_mapper.dart';

class PostUseCase {
  final PostRepository _postRepository;
  final StorageRepository _storageRepository;

  PostUseCase(this._postRepository, this._storageRepository);

  Future<List<Post>> fetchPostFromUser(Auth auth) {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return _postRepository.fetchPostsFromUser(request);
    } on PostException catch (e) {
      throw PostException(e.message);
    }
  }

  Future<List<String>> uploadMediaToStorage(List<File> media, userId) {
    return _storageRepository.uploadImages(media,userId);
  }

  Future<String> createPost(CreatePostInput post) async {
    
    try {
      return _postRepository.createPost(post);
    } on PostException catch (e) {
      throw PostException(e.message);
    }
  }
}
