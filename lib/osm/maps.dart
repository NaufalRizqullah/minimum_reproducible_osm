import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OsmMaps extends StatefulWidget {
  const OsmMaps({
    super.key,
  });

  @override
  State<OsmMaps> createState() => _OsmMapsState();
}

class _OsmMapsState extends State<OsmMaps> {
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    // Startting initial location (in first never move to current location)
    _followOnLocationUpdate = FollowOnLocationUpdate.always;
    _followCurrentLocationStreamController = StreamController<double?>();

    // get Permission for access location
    getPermisionLocation();
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: const LatLng(-8.5817467, 116.1051276),
        zoom: 17,
        maxZoom: 18,
        // Stop following the location marker on the map if user interacted with the map.
        onPositionChanged: (MapPosition position, bool hasGesture) {
          if (hasGesture &&
              _followOnLocationUpdate != FollowOnLocationUpdate.never) {
            setState(
              () => _followOnLocationUpdate = FollowOnLocationUpdate.never,
            );
          }
        },
      ),
      nonRotatedChildren: [
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async {
              // Follow the location marker on the map when location updated until user interact with the map.
              setState(
                () => _followOnLocationUpdate = FollowOnLocationUpdate.always,
              );
              // Follow the location marker on the map and zoom the map to level 18.
              _followCurrentLocationStreamController.add(18);
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
        CurrentLocationLayer(
          followCurrentLocationStream:
              _followCurrentLocationStreamController.stream,
          followOnLocationUpdate: _followOnLocationUpdate,
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
}
