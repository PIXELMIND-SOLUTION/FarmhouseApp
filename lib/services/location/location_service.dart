import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class LocationService {
  // Check and request location permissions
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable them.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied. Please enable from settings.',
      );
    }

    return true;
  }

  // Get current position
  Future<Position> getCurrentPosition() async {
    await handleLocationPermission();

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // Get address from coordinates
  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}';
      }
      return 'Address not found';
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }

  // Get coordinates from address
  Future<Location> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return locations.first;
      }
      throw Exception('Location not found');
    } catch (e) {
      throw Exception('Failed to get coordinates: $e');
    }
  }

  // Send live location to API
  Future<void> updateLiveLocation(double lat, double lng) async {
    try {
      final user = await SharedPrefs.getUser();
      if (user == null) {
        throw Exception('User not logged in');
      }

      final url = ApiConstants.livelocation.replaceAll('userId', user.id);
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'lat': lat, 'lng': lng}),
      );

      print('response status code for location ${response.statusCode}');
      print('response bodyyyyyyyyyyyyyyyyy for location ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to update location: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating live location: $e');
    }
  }

  // Get current location and send to API
  Future<Map<String, dynamic>> getCurrentLocationAndUpdate() async {
    try {
      final position = await getCurrentPosition();
      await updateLiveLocation(position.latitude, position.longitude);

      final address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': address,
      };
    } catch (e) {
      throw Exception('Error getting location: $e');
    }
  }

  // Listen to location changes (for real-time tracking)
  Stream<Position> getPositionStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  // Calculate distance between two points (in kilometers)
  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng) /
        1000;
  }
}
