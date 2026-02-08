// import 'dart:convert';
// import 'package:farmhouse_app/constant/api_constant.dart';
// import 'package:farmhouse_app/views/models/farmhouse_model.dart';
// import 'package:http/http.dart' as http;

// class FarmhouseService {
//   Future<NearbyFarmhouseResponse?> getNearbyFarmhouses(String userId) async {
//     try {
//       final url = ApiConstants.nearbyfarmhouse.replaceAll('userId', userId);

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//       );

//       print(
//         'response status code for nearby farmhouses ${response.statusCode}',
//       );
//       print('response bodyyyyy for nearby farmhouses ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return NearbyFarmhouseResponse.fromJson(data);
//       } else {
//         print('Error: ${response.statusCode} - ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Exception in getNearbyFarmhouses: $e');
//       return null;
//     }
//   }

//   /// Fetch nearby farmhouses with custom error handling
//   Future<Map<String, dynamic>> getNearbyFarmhousesWithError(
//     String userId,
//   ) async {
//     try {
//       final url = ApiConstants.nearbyfarmhouse.replaceAll('userId', userId);

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return {
//           'success': true,
//           'data': NearbyFarmhouseResponse.fromJson(data),
//         };
//       } else {
//         return {
//           'success': false,
//           'error': 'Failed to load farmhouses: ${response.statusCode}',
//         };
//       }
//     } catch (e) {
//       return {'success': false, 'error': 'Network error: $e'};
//     }
//   }
// }


















import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:farmhouse_app/views/models/farmhouse_model.dart';
import 'package:http/http.dart' as http;

class FarmhouseService {
  Future<NearbyFarmhouseResponse?> getNearbyFarmhouses(
    String userId, {
    String? date,
    int? maxDistance,
  }) async {
    try {
      final baseUrl = ApiConstants.nearbyfarmhouse.replaceAll('userId', userId);
      
      // Build query parameters
      final queryParams = <String, String>{};
      if (date != null) queryParams['date'] = date;
      if (maxDistance != null) queryParams['maxDistance'] = maxDistance.toString();
      
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      print('response status code for nearby farmhouses ${response.statusCode}');
      print('response bodyyyyy for nearby farmhouses ${response.body}');
      print('queryyyyyyyyyyyyyyyyyyy paramssssssssssss $queryParams');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NearbyFarmhouseResponse.fromJson(data);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception in getNearbyFarmhouses: $e');
      return null;
    }
  }

  /// Fetch nearby farmhouses with custom error handling
  Future<Map<String, dynamic>> getNearbyFarmhousesWithError(
    String userId, {
    String? date,
    int? maxDistance,
  }) async {
    try {
      final baseUrl = ApiConstants.nearbyfarmhouse.replaceAll('userId', userId);
      
      // Build query parameters
      final queryParams = <String, String>{};
      if (date != null) queryParams['date'] = date;
      if (maxDistance != null) queryParams['maxDistance'] = maxDistance.toString();
      
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'data': NearbyFarmhouseResponse.fromJson(data),
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to load farmhouses: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }
}