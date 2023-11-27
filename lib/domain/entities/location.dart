class LocationEntity {
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? country;
  final String? state;
  final String? city;
  final String? locationId;

  LocationEntity(
      {this.country,
      this.state,
      this.city,
      this.latitude,
      this.longitude,
      this.name,
      this.locationId});
}
