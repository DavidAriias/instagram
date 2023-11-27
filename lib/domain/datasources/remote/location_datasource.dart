import 'package:instagram/domain/entities/entities.dart';

abstract class LocationDatasource {
  Future<List<LocationEntity>> getLocationByName(String locationName);
  Future<List<LocationEntity>> getLocationNameByCoordinates(LocationEntity coordinates);
}
