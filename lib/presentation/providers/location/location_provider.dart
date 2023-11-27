import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/location/location_use_case.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/domain/entities/entities.dart';

final locationProvider =
    StateNotifierProvider<LocationNotifier, LocationEntity>((ref) {
  return LocationNotifier(locationUseCase);
});

class LocationNotifier extends StateNotifier<LocationEntity> {
  final LocationUseCase _locationUseCase;
  
  LocationNotifier(this._locationUseCase)
      : super(LocationEntity());

  Future<void> getCurrentLocation() async {
    state = await _locationUseCase.getCurrentLocation();
  }
  


}
