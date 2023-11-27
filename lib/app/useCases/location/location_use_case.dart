import 'package:instagram/domain/entities/entities.dart';
import 'package:instagram/infraestructure/services/services.dart';

import '../../../domain/repositories/repositories.dart';

class LocationUseCase {
  final LocationService _locationService;
  final LocationRepository _locationRepository;

  LocationUseCase(this._locationService, this._locationRepository);

  Future<LocationEntity> getCurrentLocation() {
    return _locationService.getCurrentLocation();
  }

  Future<List<LocationEntity>> getLocationByName(String locationName) {
    return _locationRepository.getLocationByName(locationName);
  }

  Future<List<LocationEntity>> getLocationByCoordinates(
      LocationEntity coordinates) {
    return _locationRepository.getLocationNameByCoordinates(coordinates);
  }
}
