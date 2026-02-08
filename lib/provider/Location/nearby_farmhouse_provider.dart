// import 'package:farmhouse_app/services/location/nearby_farmhouse_service.dart';
// import 'package:farmhouse_app/utils/helper_function.dart';
// import 'package:flutter/foundation.dart';
// import 'package:farmhouse_app/views/models/farmhouse_model.dart';

// enum FarmhouseStatus { idle, loading, loaded, error }

// class FarmhouseProvider extends ChangeNotifier {
//   final FarmhouseService _farmhouseService = FarmhouseService();

//   FarmhouseStatus _status = FarmhouseStatus.idle;
//   List<Farmhouse> _farmhouses = [];
//   UserLocation? _userLocation;
//   String? _errorMessage;
//   int _count = 0;

//   // Getters
//   FarmhouseStatus get status => _status;
//   List<Farmhouse> get farmhouses => _farmhouses;
//   UserLocation? get userLocation => _userLocation;
//   String? get errorMessage => _errorMessage;
//   int get count => _count;
//   bool get isLoading => _status == FarmhouseStatus.loading;
//   bool get hasError => _status == FarmhouseStatus.error;

//   /// Fetch nearby farmhouses using the logged-in user's ID
//   Future<void> fetchNearbyFarmhouses() async {
//     final user = await SharedPrefs.getUser();
    
//     if (user == null) {
//       _status = FarmhouseStatus.error;
//       _errorMessage = 'User not logged in';
//       notifyListeners();
//       return;
//     }

//     await fetchNearbyFarmhousesByUserId(user.id);
//   }

//   Future<void> fetchNearbyFarmhousesByUserId(String userId) async {
//     _status = FarmhouseStatus.loading;
//     _errorMessage = null;
//     notifyListeners();

//     final result = await _farmhouseService.getNearbyFarmhousesWithError(userId);

//     if (result['success'] == true) {
//       final response = result['data'] as NearbyFarmhouseResponse;
//       _farmhouses = response.farmhouses;
//       _userLocation = response.userLocation;
//       _count = response.count;
//       _status = FarmhouseStatus.loaded;
//     } else {
//       _status = FarmhouseStatus.error;
//       _errorMessage = result['error'];
//       _farmhouses = [];
//       _userLocation = null;
//       _count = 0;
//     }

//     notifyListeners();
//   }

//   /// Refresh farmhouses
//   Future<void> refresh() async {
//     await fetchNearbyFarmhouses();
//   }

//   /// Clear all data
//   void clear() {
//     _status = FarmhouseStatus.idle;
//     _farmhouses = [];
//     _userLocation = null;
//     _errorMessage = null;
//     _count = 0;
//     notifyListeners();
//   }

//   Farmhouse? getFarmhouseById(String id) {
//     try {
//       return _farmhouses.firstWhere((farmhouse) => farmhouse.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   /// Check if a farmhouse is in wishlist for current user
//   Future<bool> isFarmhouseInWishlist(String farmhouseId) async {
//     final user = await SharedPrefs.getUser();
//     if (user == null) return false;

//     final farmhouse = getFarmhouseById(farmhouseId);
//     return farmhouse?.wishlist.contains(user.id) ?? false;
//   }
// }













import 'package:farmhouse_app/services/location/nearby_farmhouse_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/foundation.dart';
import 'package:farmhouse_app/views/models/farmhouse_model.dart';

enum FarmhouseStatus { idle, loading, loaded, error }

class FarmhouseProvider extends ChangeNotifier {
  final FarmhouseService _farmhouseService = FarmhouseService();

  FarmhouseStatus _status = FarmhouseStatus.idle;
  List<Farmhouse> _farmhouses = [];
  UserLocation? _userLocation;
  String? _errorMessage;
  int _count = 0;

  // Getters
  FarmhouseStatus get status => _status;
  List<Farmhouse> get farmhouses => _farmhouses;
  UserLocation? get userLocation => _userLocation;
  String? get errorMessage => _errorMessage;
  int get count => _count;
  bool get isLoading => _status == FarmhouseStatus.loading;
  bool get hasError => _status == FarmhouseStatus.error;

  /// Fetch nearby farmhouses using the logged-in user's ID
  Future<void> fetchNearbyFarmhouses({
    String? date,
    int? maxDistance,
  }) async {
    final user = await SharedPrefs.getUser();
    
    if (user == null) {
      _status = FarmhouseStatus.error;
      _errorMessage = 'User not logged in';
      notifyListeners();
      return;
    }

    await fetchNearbyFarmhousesByUserId(
      user.id,
      date: date,
      maxDistance: maxDistance,
    );
  }

  Future<void> fetchNearbyFarmhousesByUserId(
    String userId, {
    String? date,
    int? maxDistance,
  }) async {
    _status = FarmhouseStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _farmhouseService.getNearbyFarmhousesWithError(
      userId,
      date: date,
      maxDistance: maxDistance,
    );

    if (result['success'] == true) {
      final response = result['data'] as NearbyFarmhouseResponse;
      _farmhouses = response.farmhouses;
      _userLocation = response.userLocation;
      _count = response.count;
      _status = FarmhouseStatus.loaded;
    } else {
      _status = FarmhouseStatus.error;
      _errorMessage = result['error'];
      _farmhouses = [];
      _userLocation = null;
      _count = 0;
    }

    notifyListeners();
  }

  /// Refresh farmhouses
  Future<void> refresh({
    String? date,
    int? maxDistance,
  }) async {
    await fetchNearbyFarmhouses(
      date: date,
      maxDistance: maxDistance,
    );
  }

  /// Clear all data
  void clear() {
    _status = FarmhouseStatus.idle;
    _farmhouses = [];
    _userLocation = null;
    _errorMessage = null;
    _count = 0;
    notifyListeners();
  }

  Farmhouse? getFarmhouseById(String id) {
    try {
      return _farmhouses.firstWhere((farmhouse) => farmhouse.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Check if a farmhouse is in wishlist for current user
  Future<bool> isFarmhouseInWishlist(String farmhouseId) async {
    final user = await SharedPrefs.getUser();
    if (user == null) return false;

    final farmhouse = getFarmhouseById(farmhouseId);
    return farmhouse?.wishlist.contains(user.id) ?? false;
  }
}