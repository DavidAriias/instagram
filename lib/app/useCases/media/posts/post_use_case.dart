import 'package:instagram/domain/repositories/remote/post_repository.dart';
import 'package:instagram/infraestructure/errors/post_error.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../infraestructure/mappers/user_mapper.dart';

class PostUseCase {
  final PostRepository _postRepository;

  PostUseCase(this._postRepository);

  Future<List<Post>> fetchPostFromUser(Auth auth) {
    final request = UserMapper.mapAuthEntityToUserInput(auth);
    try {
      return _postRepository.fetchPostsFromUser(request);
    } on PostException catch (e) {
      throw PostException(e.message);
    }
  }
}
