import '../../../domain/entities/entities.dart';

abstract class LocationService {
  Future<LocationEntity> getCurrentLocation();
}
