import 'package:dio/dio.dart';
import 'package:instagram/config/config.dart';
import 'package:instagram/domain/entities/location.dart';
import 'package:instagram/infraestructure/errors/location_error.dart';
import 'package:instagram/infraestructure/mappers/location_mapper.dart';
import 'package:instagram/infraestructure/models/models.dart';

import '../../../../domain/datasources/datasource.dart';

class LocationMapboxDatasourceImpl extends LocationDatasource {
  final client = Dio(BaseOptions(
      baseUrl: 'https://api.mapbox.com/geocoding/v5',
      queryParameters: {'access_token': Environment.mapboxToken}));
  @override
  Future<List<LocationEntity>> getLocationByName(String locationName) async {
    try {
      final response =
          await client.get('/mapbox.places/$locationName.json?proximity=ip');

      if (response.statusCode != 200) {
        throw LocationException(response.statusMessage!);
      }

      final result = LocationResponse.fromJson(response.data);

      return result.features
          .map(LocationMapper.mapLocationResponseToLocationEntity)
          .toList();
    } on LocationException catch (e) {
      throw LocationException(e.message);
    }
  }

  @override
  Future<List<LocationEntity>> getLocationNameByCoordinates(
      LocationEntity coordinates) async {
    try {
      final response = await client.get(
          '/mapbox.places/$coordinates.longitude,$coordinates.latitude.json?proximity=ip');

      if (response.statusCode != 200) {
        throw LocationException(response.statusMessage!);
      }

      final result = LocationResponse.fromJson(response.data);

      return result.features
          .map(LocationMapper.mapLocationResponseToLocationEntity)
          .toList();
    } on LocationException catch (e) {
      throw LocationException(e.message);
    }
  }
}
