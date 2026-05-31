class AppConstants {
  // OSRM routing API (free, no key needed)
  static const String osrmBaseUrl =
      'https://router.project-osrm.org/route/v1/driving';

  // Nominatim search API (free, no key needed)
  static const String nominatimBaseUrl =
      'https://nominatim.openstreetmap.org';

  // Default map tile URL (OpenStreetMap)
  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // Satellite tile (optional alternative)
  static const String satelliteTileUrl =
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';

  // Animation durations
  static const Duration markerAnimDuration = Duration(milliseconds: 50);
  static const Duration cameraAnimDuration = Duration(milliseconds: 600);
  static const Duration routeDrawDuration = Duration(milliseconds: 1200);

  // Marker animation total steps
  static const int markerAnimSteps = 200;

  static const double defaultZoom = 15.0;
  static const double routeZoom = 13.0;
}