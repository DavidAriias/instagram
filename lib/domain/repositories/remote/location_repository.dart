import 'package:instagram/domain/entities/entities.dart';

abstract class LocationRepository {
  Future<List<LocationEntity>> getLocationByName(String locationName);
  Future<List<LocationEntity>> getLocationNameByCoordinates(LocationEntity coordinates);
}
