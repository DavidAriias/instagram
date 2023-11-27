import 'package:graphql/client.dart';
import 'package:instagram/domain/datasources/remote/post_datasource.dart';
import 'package:instagram/infraestructure/errors/post_error.dart';
import 'package:instagram/infraestructure/graphql_schemas/queries/post_queries.dart';
import '../../../../domain/entities/entities.dart';
import '../../../graphql_schemas/graphql.dart';
import '../../../graphql_schemas/graphql_client.dart';
import '../../../mappers/post_mapper.dart';
import '../../../models/models.dart';

class PostGraphQlDatasourceImpl extends PostDataSource {
  @override
  Future<List<Post>> fetchPostsFromUser(UserInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document: gql(MediaSubtypeFragment.replyFragment +
            MediaSubtypeFragment.commentFragment +
            MediaSubtypeFragment.songFragment +
            MediaFragments.postFragment +
            PostQueries.fetchPosts),
        variables: {'userId': input.userId});

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw PostException(result.exception!.graphqlErrors.first.message);
      }

      final response = FetchPostResponse.fromJson(result.data!);
      final posts = response.userProfile.posts.nodes;

      return posts.map(PostMapper.mapPostNodeToPostEntity).toList();
    } on PostException catch (e) {
      throw PostException(e.message);
    }
  }
}
