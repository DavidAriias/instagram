import 'package:instagram/domain/datasources/remote/post_datasource.dart';
import 'package:instagram/infraestructure/models/models.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/remote/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final PostDataSource _dataSource;

  PostRepositoryImpl(this._dataSource);
  @override
  Future<List<Post>> fetchPostsFromUser(UserInput input) {
    return _dataSource.fetchPostsFromUser(input);
  }
  
  @override
  Future<String> createPost(CreatePostInput input) {
   return _dataSource.createPost(input);
  }
}
