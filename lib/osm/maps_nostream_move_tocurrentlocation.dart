import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OsmMaps2 extends StatefulWidget {
  const OsmMaps2({
    super.key,
  });

  @override
  State<OsmMaps2> createState() => _OsmMaps2State();
}

class _OsmMaps2State extends State<OsmMaps2> {
  LocationMarkerPosition _currentPosition = LocationMarkerPosition(
    latitude: 0,
    longitude: 0,
    accuracy: 0,
  );
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // get Permission for access location
    getPermisionLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: const LatLng(-8.5817467, 116.1051276),
        zoom: 17,
        maxZoom: 18,
      ),
      nonRotatedChildren: [
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async {
              // get current location
              var location = await getCurrentLocation();

              setState(
                () {
                  _currentPosition = LocationMarkerPosition(
                    latitude: location.latitude,
                    longitude: location.longitude,
                    accuracy: 0,
                  );

                  //  to zoom into location
                  _mapController.move(
                    LatLng(location.latitude, location.longitude),
                    16,
                  );
                },
              );
            },
            child: const Icon(
              Icons.my_location,
              color: Colors.red,
            ),
          ),
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 18,
        ),

        // Custom Party-3rd for current location
        AnimatedLocationMarkerLayer(
          position: _currentPosition,
        ),
      ],
    );
  }

  Future<void> getPermisionLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // 1. Check if disabled, the enabled
    // Location Services are Disabled
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    }

    // Check Permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }

    // Location Permission are Permanently Denied, We cant access the Location!
    if (permission == LocationPermission.deniedForever) {}
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
