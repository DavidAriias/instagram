import 'package:instagram/domain/entities/entities.dart';
import '../../../infraestructure/models/models.dart';

abstract class PostRepository{
   Future<List<Post>> fetchPostsFromUser(UserInput input);
}