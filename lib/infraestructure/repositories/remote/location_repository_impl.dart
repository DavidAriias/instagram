import 'package:instagram/domain/datasources/datasource.dart';
import 'package:instagram/domain/entities/location.dart';

import '../../../domain/repositories/repositories.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationDatasource _locationDatasource;

  LocationRepositoryImpl(this._locationDatasource);

  @override
  Future<List<LocationEntity>> getLocationByName(String locationName) {
    return _locationDatasource.getLocationByName(locationName);
  }

  @override
  Future<List<LocationEntity>> getLocationNameByCoordinates(
      LocationEntity coordinates) {
    return _locationDatasource.getLocationNameByCoordinates(coordinates);
  }
}
