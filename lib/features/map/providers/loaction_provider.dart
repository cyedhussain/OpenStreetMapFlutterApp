// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map/features/map/model/location_state.dart';

class LocationNotifier extends StateNotifier<LocationState>{
  StreamSubscription<Position>? _sub;
  LocationNotifier(): super (const LocationState(isLoading: true)){
    // this is the entry point 
    _init();
  }
  Future<void> _init() async {
    final permission = await checkPermission();
    if (!permission) {
      state = state.copyWith(
        isLoading: false,
        error: 'location permission denied'
      );
      return;
      
    }

    try {
        final pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high
          )
        );
        state =state.copyWith(
          position: LatLng(pos.latitude, pos.longitude),
          speed: pos.speed,
          heading: pos.heading,
          isLoading: false
        );
        _startStream();

    } catch (e) {
      state =state.copyWith(isLoading: false ,error: e.toString());
    }

  }
  // this is the continuous stream 
  void _startStream() {
    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,//updates every five meter
      ),

    ).listen((pos){
      state = state.copyWith(
        position: LatLng(pos.latitude, pos.longitude),
        heading: pos.heading,
        speed: pos.speed
      );
    } );
  }
  // user permission 

  Future<bool> checkPermission() async {
   bool serviceEnable = await Geolocator.isLocationServiceEnabled();
   if (!serviceEnable) {
     return false;
   } 
   LocationPermission permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     try {
       permission = await Geolocator.requestPermission();
     } on PermissionRequestInProgressException {
      await Future.delayed(const Duration(milliseconds: 500));
      permission = await Geolocator.checkPermission();
     }
   }
   return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
  final locationProvider = StateNotifierProvider<LocationNotifier ,LocationState>((ref) => LocationNotifier() );

}