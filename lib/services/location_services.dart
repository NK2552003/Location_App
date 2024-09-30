import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:geolocator/geolocator.dart';

class LocationService {
  static const double targetLatitude = 30.3421156; // Set your target latitude
  static const double targetLongitude = 77.8879061; // Set your target longitude
  static const double radius = 100; // 100 meters

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void startTracking(Function(bool) onLocationUpdate) {
    // Request location permissions
    Geolocator.requestPermission().then((permission) {
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // Configure BackgroundGeolocation
        bg.BackgroundGeolocation.onLocation((bg.Location location) {
          final double distance = Geolocator.distanceBetween(
            location.coords.latitude,
            location.coords.longitude,
            targetLatitude,
            targetLongitude,
          );
          bool isInRadius = distance <= radius;
          onLocationUpdate(isInRadius);

          _firestore.collection('locations').doc('userId').set({
            'status': isInRadius ? 'In Range' : 'Out of Range',
            'timestamp': FieldValue.serverTimestamp(),
          });

          onLocationUpdate(isInRadius);
        });

        bg.BackgroundGeolocation.ready(bg.Config(
          desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
          distanceFilter: 10.0,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
        )).then((bg.State state) {
          if (!state.enabled) {
            bg.BackgroundGeolocation.start();
          }
        });
      }
    });
  }
}
