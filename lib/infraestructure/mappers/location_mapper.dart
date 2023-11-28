import 'package:geolocator/geolocator.dart';
import 'package:instagram/domain/entities/entities.dart';
import 'package:instagram/infraestructure/models/models.dart';

class LocationMapper {
  static LocationEntity mapLocationDataToLocationEntity(Position location) =>
      LocationEntity(
          latitude: location.latitude, longitude: location.longitude);

  static LocationEntity mapLocationResponseToLocationEntity(Feature feature) =>
      LocationEntity(
        locationId: feature.id,
        latitude: feature.geometry.coordinates[1],
        longitude: feature.geometry.coordinates[0],
        name: feature.placeName,
        country:  feature.context.isNotEmpty
            ? feature.context
                .firstWhere((context) => context.id.startsWith('country'),
                    orElse: () => Context(id: '', mapboxId: '', text: ''))
                .text
            : '',
        state: feature.context.isNotEmpty
            ? feature.context
                .firstWhere((context) => context.id.startsWith('place'),
                    orElse: () => Context(id: '', mapboxId: '', text: ''))
                .text
            : '',
        city:  feature.context.isNotEmpty
            ? feature.context
                .firstWhere((context) => context.id.startsWith('city'),
                    orElse: () => Context(id: '', mapboxId: '', text: ''))
                .text
            : '',
      );
}
