import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/app/useCases/location/location_use_case.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/domain/entities/entities.dart';

final listLocationProvider =
    StateNotifierProvider<ListLocationNotifier, List<LocationEntity>>((ref) {
  return ListLocationNotifier(locationUseCase);
});

class ListLocationNotifier extends StateNotifier<List<LocationEntity>> {
  final LocationUseCase _locationUseCase;
  ListLocationNotifier(this._locationUseCase) : super([]);

  Future<void> getLocationByName(String locationName) async {
    state = await _locationUseCase.getLocationByName(locationName);
  }

  Future<void> getLocationsByCurrentLocation() async {
    if (state.isNotEmpty) return;
    final currentLocation = await _locationUseCase.getCurrentLocation();
    state = await _locationUseCase.getLocationByCoordinates(currentLocation);
  }
  
}
