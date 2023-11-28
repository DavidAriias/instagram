
import '../../../infraestructure/models/models.dart';
import '../../entities/entities.dart';

abstract class PostDataSource {
  Future<List<Post>> fetchPostsFromUser(UserInput input);
  Future<String> createPost(CreatePostInput input);
}
