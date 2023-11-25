import 'package:graphql/client.dart';
import 'package:instagram/domain/datasources/datasource.dart';
import 'package:instagram/infraestructure/errors/music_error.dart';
import 'package:instagram/infraestructure/graphql_schemas/graphql.dart';
import 'package:instagram/infraestructure/graphql_schemas/graphql_client.dart';
import 'package:instagram/infraestructure/mappers/music_mapper.dart';

import '../../../domain/entities/entities.dart';
import '../../models/models.dart';

class MusicGraphQlDatasourceImpl extends MusicDataSource {
  
  @override
  Future<List<Song>> getSongsByUser(SongInput input) async {
    final client = await initializeGraphQLClient(input.accessToken);

    final options = QueryOptions(
        document: gql(MusicQueries.searchSongByName),
        variables: {
          'trackName': input.songName,
          'first': 10
        });

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw MusicException(result.exception!.graphqlErrors.first.message);
      }

      final response = SearchSongResponse.fromJson(result.data!);

      final songs = response.searchSongByName.nodes;

      return songs.map(MusicMapper.mapSearchSongByNameToSongEntity).toList();
    } on MusicException catch (e) {
      throw MusicException(e.message);
    }
  }
}
