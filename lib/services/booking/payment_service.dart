import 'package:dio/dio.dart';
import 'package:farmhouse_app/constant/api_constant.dart';

class PaymentService {
  final Dio _dio = Dio();

  /// Creates a payment order
  /// Requires [verificationId], [transactionId], and [userId]
  Future<Map<String, dynamic>> createPayment({
    required String verificationId,
    required String transactionId,
    required String userId,
  }) async {
    try {
      final payload = {
        "verificationId": verificationId,
        "transactionId": transactionId,
        "userId": userId,
      };

      final Response response = await _dio.post(
        ApiConstants.payment,
        data: payload,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      print('response status code for create payment ${response.statusCode}');

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data["message"] ?? "Payment failed");
      }
      throw Exception("Network error: ${e.message}");
    }
  }
}