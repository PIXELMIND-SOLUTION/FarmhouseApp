// import 'package:dio/dio.dart';
// import 'package:farmhouse_app/constant/api_constant.dart';

// class PaymentService {
//   final Dio _dio = Dio();

//   /// Creates a payment order
//   /// Requires [verificationId], [transactionId], and [userId]
// Future<Map<String, dynamic>> createPayment({
//   required String slotId,
//   required String farmId,
//   required String transactionId,
//   required String userId,
// }) async {
//   try {
//     final payload = {
//       "farmhouseId": farmId,
//       "slotId": slotId,
//       "transactionId": transactionId,
//       "userId": userId,
//     };

//     // ✅ PRINT PAYLOAD
//     print("📤 PAYMENT PAYLOAD:");
//     print(payload);

//     final Response response = await _dio.post(
//       ApiConstants.payment,
//       data: payload,
//       options: Options(
//         headers: {
//           "Content-Type": "application/json",
//         },
//       ),
//     );

//     // ✅ PRINT RESPONSE
//     print("📥 PAYMENT RESPONSE STATUS:");
//     print(response.statusCode);

//     print("📥 PAYMENT RESPONSE BODY:");
//     print(response.data);

//     return response.data;
//   } on DioException catch (e) {
//     print("❌ PAYMENT ERROR:");
//     print(e.response?.data ?? e.message);

//     if (e.response != null) {
//       throw Exception(e.response?.data["message"] ?? "Payment failed");
//     }
//     throw Exception("Network error: ${e.message}");
//   }
// }

// }

import 'package:dio/dio.dart';
import 'package:farmhouse_app/constant/api_constant.dart';

class PaymentService {
  final Dio _dio = Dio();

  /// Creates a booking with pending payment status
  /// [farmhouseId] - ID of the selected farmhouse
  /// [slotId] - ID of the selected time slot
  /// [advancePayment] - Amount to be paid as advance (0 for full payment)
  /// [userId] - ID of the logged-in user
  Future<Map<String, dynamic>> createBooking({
    required String farmhouseId,
    required String slotId,
    required int advancePayment,
    required String userId,
  }) async {
    try {
      final payload = {
        "userId": userId,
        "farmhouseId": farmhouseId,
        "slotId": slotId,
        "advancePayment": advancePayment,
      };

      // ✅ PRINT PAYLOAD FOR DEBUGGING
      print("📤 BOOKING PAYLOAD:");
      print(payload);

      final Response response = await _dio.post(
        ApiConstants.payment,
        data: payload,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      // ✅ PRINT RESPONSE FOR DEBUGGING
      print("📥 BOOKING RESPONSE STATUS:");
      print(response.statusCode);

      print("📥 BOOKING RESPONSE BODY:");
      print(response.data);

      // Check if the response indicates success
      if (response.data['success'] == true) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? "Failed to create booking");
      }
    } on DioException catch (e) {
      print("❌ BOOKING ERROR:");
      print(e.response?.data ?? e.message);

      if (e.response != null) {
        // Extract error message from response
        String errorMessage = e.response?.data["message"] ?? "Payment failed";
        throw Exception(errorMessage);
      }
      throw Exception("Network error: ${e.message}");
    }
  }

  /// Optional: Confirm payment after Razorpay success
  /// Call this API to update booking status from 'pending' to 'confirmed'
  Future<Map<String, dynamic>> confirmPayment({
    required String bookingId,
    required String transactionId,
    required int amountPaid,
  }) async {
    try {
      final payload = {
        "bookingId": bookingId,
        "transactionId": transactionId,
        "amountPaid": amountPaid,
        "paymentStatus": "completed",
      };

      print("📤 CONFIRM PAYMENT PAYLOAD:");
      print(payload);

      // Replace with your actual confirm payment endpoint
      final Response response = await _dio.post(
        '${ApiConstants.baseUrl}/payment/confirm', // Update this endpoint
        data: payload,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("📥 CONFIRM PAYMENT RESPONSE:");
      print(response.data);

      return response.data;
    } on DioException catch (e) {
      print("❌ CONFIRM PAYMENT ERROR:");
      print(e.response?.data ?? e.message);
      throw Exception("Failed to confirm payment: ${e.message}");
    }
  }

  /// Optional: Cancel pending booking if payment fails
  Future<Map<String, dynamic>> cancelBooking({
    required String bookingId,
    required String userId,
  }) async {
    try {
      print("📤 CANCEL BOOKING REQUEST:");
      print(
        "URL: ${ApiConstants.baseUrl}/order/cancel-booking/$userId/$bookingId",
      );
      print("User ID: $userId");
      print("Booking ID: $bookingId");

      // Use DELETE method as per your endpoint
      final Response response = await _dio.post(
        '${ApiConstants.baseUrl}/order/cancel-booking/$userId/$bookingId',
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("📥 CANCEL BOOKING RESPONSE:");
      print(response.data);
      print("Response Status: ${response.statusCode}");

      return response.data;
    } on DioException catch (e) {
      print("❌ CANCEL BOOKING ERROR:");
      print("Error: ${e.message}");
      print("Response: ${e.response?.data}");
      throw Exception("Failed to cancel booking: ${e.message}");
    }
  }
}
