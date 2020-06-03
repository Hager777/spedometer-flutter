import 'dart:async';

import 'package:location/location.dart';
import 'package:my_app/datamodels/user_location.dart';

class LocationService {
  // Keep track of current Location
  UserLocation _currentLocation;
  Location location = Location();
  // Continuously emit location updates
  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(locationData.speed, locationData.speedAccuracy, locationData.time,)
            );
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(userLocation.speed, userLocation.speedAccuracy, userLocation.time);
    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}