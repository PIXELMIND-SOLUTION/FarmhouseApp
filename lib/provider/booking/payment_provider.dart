// import 'package:farmhouse_app/services/booking/payment_service.dart';
// import 'package:flutter/material.dart';

// enum PaymentStatus { idle, loading, success, error }

// class PaymentProvider with ChangeNotifier {
//   final PaymentService _service = PaymentService();

//   PaymentStatus _status = PaymentStatus.idle;
//   String _errorMessage = "";
//   Map<String, dynamic>? _paymentResponse;

//   PaymentStatus get status => _status;
//   String get errorMessage => _errorMessage;
//   Map<String, dynamic>? get paymentResponse => _paymentResponse;

//   bool get isLoading => _status == PaymentStatus.loading;

//   void _setStatus(PaymentStatus status, {String error = ""}) {
//     _status = status;
//     _errorMessage = error;
//     notifyListeners();
//   }

//   /// Call this after Razorpay/payment gateway returns
//   /// [verificationId] from your verify-slot response
//   /// [transactionId] from Razorpay onSuccess callback
//   /// [userId] from SharedPrefs
//   Future<void> createPayment({
//     required String farmId,
//     required String slotId,

//     required String transactionId,
//     required String userId,
//   }) async {
//     _setStatus(PaymentStatus.loading);

//     try {
//       _paymentResponse = await _service.createPayment(
//         farmId: farmId,
//         slotId: slotId,

//         transactionId: transactionId,
//         userId: userId,
//       );

//       print('transaction idddddddddddddddd $transactionId');
//       print('userrrrrrrrrrrrrrrrrrrrrrrrr iddddddddddddddddd $userId');
//       print('slottttttttttttttttttttttt iddddddddddddd $slotId');
//       print('farmmmmmmmmmmmmmmmmmmmmm iddddddddddddd $farmId');

//       _setStatus(PaymentStatus.success);
//     } catch (e) {
//       _setStatus(PaymentStatus.error, error: e.toString());
//     }
//   }

//   void reset() {
//     _status = PaymentStatus.idle;
//     _errorMessage = "";
//     _paymentResponse = null;
//     notifyListeners();
//   }
// }

import 'package:farmhouse_app/services/booking/payment_service.dart';
import 'package:flutter/material.dart';

enum PaymentStatus { idle, loading, success, error }

class PaymentProvider with ChangeNotifier {
  final PaymentService _service = PaymentService();

  PaymentStatus _status = PaymentStatus.idle;
  String _errorMessage = "";
  Map<String, dynamic>? _bookingResponse;
  String? _currentBookingId;

  // Getters
  PaymentStatus get status => _status;
  String get errorMessage => _errorMessage;
  Map<String, dynamic>? get bookingResponse => _bookingResponse;
  String? get currentBookingId => _currentBookingId;
  bool get isLoading => _status == PaymentStatus.loading;
  bool get isSuccess => _status == PaymentStatus.success;
  bool get hasError => _status == PaymentStatus.error;

  void _setStatus(PaymentStatus status, {String error = ""}) {
    _status = status;
    _errorMessage = error;
    notifyListeners();
  }

  /// Step 1: Create booking with pending payment status
  /// Returns the booking ID if successful
  Future<String?> createBooking({
    required String farmhouseId,
    required String slotId,
    required int advancePayment,
    required String userId,
  }) async {
    _setStatus(PaymentStatus.loading);
    _currentBookingId = null;

    try {
      _bookingResponse = await _service.createBooking(
        farmhouseId: farmhouseId,
        slotId: slotId,
        advancePayment: advancePayment,
        userId: userId,
      );

      // Extract booking ID from response
      if (_bookingResponse != null && _bookingResponse!['success'] == true) {
        _currentBookingId = _bookingResponse!['bookingId'];

        print('✅ Booking created successfully');
        print('📝 Booking ID: $_currentBookingId');
        print('📦 Booking Details: ${_bookingResponse!['bookingDetails']}');

        _setStatus(PaymentStatus.success);
        return _currentBookingId;
      } else {
        throw Exception(
          _bookingResponse?['message'] ?? "Failed to create booking",
        );
      }
    } catch (e) {
      _setStatus(PaymentStatus.error, error: e.toString());
      return null;
    }
  }

  /// Step 2: Confirm payment after Razorpay success
  /// Updates booking status from pending to confirmed
  Future<bool> confirmPayment({
    required String bookingId,
    required String transactionId,
    required int amountPaid,
  }) async {
    try {
      final response = await _service.confirmPayment(
        bookingId: bookingId,
        transactionId: transactionId,
        amountPaid: amountPaid,
      );

      print('✅ Payment confirmed for booking: $bookingId');
      print('📝 Response: $response');

      return true;
    } catch (e) {
      print('❌ Error confirming payment: $e');
      _setStatus(PaymentStatus.error, error: e.toString());
      return false;
    }
  }

  /// Optional: Cancel pending booking if payment fails or user cancels
  Future<bool> cancelBooking({
    required String bookingId,
    required String userId,
  }) async {
    try {
      await _service.cancelBooking(bookingId: bookingId, userId: userId);
      print('✅ Booking cancelled: $bookingId');
      return true;
    } catch (e) {
      print('❌ Error cancelling booking: $e');
      return false;
    }
  }

  /// Reset all states
  void reset() {
    _status = PaymentStatus.idle;
    _errorMessage = "";
    _bookingResponse = null;
    _currentBookingId = null;
    notifyListeners();
  }

  /// Check if booking was created successfully
  bool hasValidBooking() {
    return _currentBookingId != null && _bookingResponse?['success'] == true;
  }

  /// Get booking details from response
  Map<String, dynamic>? getBookingDetails() {
    return _bookingResponse?['bookingDetails'];
  }

  /// Get payment info from booking details
  Map<String, dynamic>? getPaymentInfo() {
    final details = getBookingDetails();
    return details?['paymentInfo'];
  }

  /// Get booking status
  String? getBookingStatus() {
    final details = getBookingDetails();
    return details?['bookingStatus'];
  }

  /// Get farmhouse name from booking details
  String? getFarmhouseName() {
    final details = getBookingDetails();
    return details?['farmhouseName'];
  }

  /// Get slot info from booking details
  Map<String, dynamic>? getSlotInfo() {
    final details = getBookingDetails();
    return details?['slotInfo'];
  }
}
