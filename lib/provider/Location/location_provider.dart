import 'dart:async';
import 'package:farmhouse_app/services/location/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  // State variables
  double? _latitude;
  double? _longitude;
  String? _address;
  bool _isLoading = false;
  String? _error;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isTracking = false;

  // Getters
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get address => _address;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isTracking => _isTracking;

  // Check if location data is available
  bool get hasLocation => _latitude != null && _longitude != null;

  // Get current location and update API
  Future<void> getCurrentLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final locationData =
          await _locationService.getCurrentLocationAndUpdate();

      _latitude = locationData['latitude'];
      _longitude = locationData['longitude'];
      _address = locationData['address'];
      _error = null;
    } catch (e) {
      _error = e.toString();
      _latitude = null;
      _longitude = null;
      _address = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update location without getting current position (manual coordinates)
  Future<void> updateLocation(double lat, double lng) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _locationService.updateLiveLocation(lat, lng);
      _latitude = lat;
      _longitude = lng;

      // Get address for the coordinates
      _address = await _locationService.getAddressFromCoordinates(lat, lng);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get address from coordinates
  Future<void> getAddressFromCoordinates(double lat, double lng) async {
    try {
      _address = await _locationService.getAddressFromCoordinates(lat, lng);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Get coordinates from address string
  Future<Map<String, double>?> getCoordinatesFromAddress(
      String address) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final location =
          await _locationService.getCoordinatesFromAddress(address);
      _isLoading = false;
      notifyListeners();
      return {
        'latitude': location.latitude,
        'longitude': location.longitude,
      };
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Start real-time location tracking
  void startLocationTracking() {
    if (_isTracking) return;

    _isTracking = true;
    notifyListeners();

    _positionStreamSubscription = _locationService.getPositionStream().listen(
      (Position position) async {
        _latitude = position.latitude;
        _longitude = position.longitude;

        // Update API with new location
        try {
          await _locationService.updateLiveLocation(
            position.latitude,
            position.longitude,
          );

          // Update address
          _address = await _locationService.getAddressFromCoordinates(
            position.latitude,
            position.longitude,
          );
        } catch (e) {
          _error = e.toString();
        }

        notifyListeners();
      },
      onError: (error) {
        _error = error.toString();
        _isTracking = false;
        notifyListeners();
      },
    );
  }

  // Stop real-time location tracking
  void stopLocationTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    _isTracking = false;
    notifyListeners();
  }

  // Calculate distance from current location to a point
  double? calculateDistanceTo(double targetLat, double targetLng) {
    if (_latitude == null || _longitude == null) return null;

    return _locationService.calculateDistance(
      _latitude!,
      _longitude!,
      targetLat,
      targetLng,
    );
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Reset location data
  void resetLocation() {
    _latitude = null;
    _longitude = null;
    _address = null;
    _error = null;
    _isLoading = false;
    stopLocationTracking();
    notifyListeners();
  }

  @override
  void dispose() {
    stopLocationTracking();
    super.dispose();
  }
}