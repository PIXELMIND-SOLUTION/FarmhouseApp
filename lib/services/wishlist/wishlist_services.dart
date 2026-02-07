// wishlist_service.dart

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:farmhouse_app/model/wishlist_model.dart';
import 'package:farmhouse_app/views/models/wishlist_model.dart';

class WishlistService {
  final Dio _dio = Dio();
  static const String _baseUrl = "http://31.97.206.144:5124/api";

  /// Fetches all wishlisted farmhouses for a given userId
  Future<WishlistResponseModel> getWishlist(String userId) async {
    try {
      final Response response = await _dio.get("$_baseUrl/get-wishlist/$userId");

      print('Response status code for get wishlist ${response.statusCode}');
            print('Response bodyyy for get wishlist ${response.data}');


      if (response.statusCode == 200) {
        return WishlistResponseModel.fromJson(response.data);
      }

      throw Exception("Failed to fetch wishlist. Status: ${response.statusCode}");
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Toggles (add/remove) a farmhouse in the user's wishlist.
  /// The same endpoint handles both add and remove — server decides based on current state.
  Future<WishlistToggleResponseModel> toggleWishlist({
    required String farmhouseId,
    required String userId,
  }) async {
    try {
      final Response response =
          await _dio.post("$_baseUrl/$farmhouseId/wishlist/$userId");

          
      print('Response status code for add to  wishlist ${response.statusCode}');
            print('Response bodyyy for add to wishlist ${response.data}');

      if (response.statusCode == 200) {
        return WishlistToggleResponseModel.fromJson(response.data);
      }

      throw Exception("Failed to toggle wishlist. Status: ${response.statusCode}");
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  /// Extracts a readable error message from a DioException
  String _handleError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'];
      }
      return "Server error: ${e.response!.statusCode}";
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionTimeout) {
      return "Connection timed out. Please check your internet.";
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return "Server took too long to respond.";
    }
    return e.message ?? "An unexpected error occurred.";
  }
}