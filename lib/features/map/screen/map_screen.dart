import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map/core/utils/app_constant.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: AppConstants.defaultZoom,
              initialCenter: LatLng(28.34, 84.33)),
            children:

              [TileLayer(maxZoom: 19,
              urlTemplate: AppConstants.osmTileUrl,
              userAgentPackageName: 'com.example.osm_flutter_app',
              )]           
             )
        ],
      ),
    );
  }
}