import 'package:geolocator/geolocator.dart';
import 'package:instagram/infraestructure/mappers/location_mapper.dart';
import 'package:instagram/infraestructure/services/services.dart';
import '../../../domain/entities/entities.dart';

class LocationServiceImpl extends LocationService {
  //TODO : AGREGAR METODOS APARTE PARA OBTENER PERMISOS, MANEJO DE ERRORES, ETC
  @override
  Future<LocationEntity> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) await Geolocator.openLocationSettings();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
      }
    }

    final currentLocation = await Geolocator.getCurrentPosition();

    return LocationMapper.mapLocationDataToLocationEntity(currentLocation);
  }
}
