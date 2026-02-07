import 'package:farmhouse_app/services/booking/book_farmhouse_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService = BookingService();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _bookingResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get bookingResponse => _bookingResponse;

  Future<bool> bookFarmhouse({
    required String farmhouseId,
    required String date,
    required String label,
    required String timing,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Get userId from SharedPreferences
      final user = await SharedPrefs.getUser();

      if (user == null) {
        _errorMessage = 'User not found. Please login again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await _bookingService.bookFarmhouse(
        farmhouseId: farmhouseId,
        userId: user.id,
        date: date,
        label: label,
        timing: timing,
      );

      print('farmhouseiddddddddddddddd $farmhouseId');
      print('useeeeeeeridd ${user.id}');
      print('dateeeeeeeeeeeeeeeeee $date');
      print('laaaaaaaaaaaabeeeeeeeeeeel $label');
      print('timinggggggggggg $timing');

      _bookingResponse = response;

      if (response['success'] == true) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Booking failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearBookingResponse() {
    _bookingResponse = null;
    notifyListeners();
  }
}
