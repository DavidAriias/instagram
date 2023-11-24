import 'package:graphql/client.dart';
import 'package:instagram/infraestructure/errors/auth_error.dart';

import '../../config/config.dart';

String url = Environment.graphqlApi;

Future<GraphQLClient> initializeGraphQLClient([String? accessToken]) async {
  try {
    final HttpLink httpLink = HttpLink(url);
    
    Link link = httpLink;

    if (accessToken != null) {
      final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $accessToken');
      link = authLink.concat(httpLink);
    }

    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  } catch (e) {
    throw AuthException('Server error connection $e');
  }
}

