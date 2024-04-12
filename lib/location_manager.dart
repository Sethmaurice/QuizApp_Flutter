import 'package:geolocator/geolocator.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._internal();

  factory LocationManager() {
    return _instance;
  }

  LocationManager._internal();

  // Method to get the current device location
  Future<Position?> getCurrentLocation() async {
    try {
      // Get the current device location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }
}
