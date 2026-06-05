import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map/core/utils/app_constant.dart';

final mapControllerProvider = Provider<MapController>((ref){
    final controller = MapController();
    ref.onDispose(controller.dispose);
    return controller;
});

// for the satellites
final isSatelliteProvider = StateProvider<bool>((ref) => false );

//for the zoom smoothly 
extension MapControllerX on MapController{
    void smoothmove(LatLng center,{double zoom = AppConstants.defaultZoom}){
        move(center, zoom);
    }
}