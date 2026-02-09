import 'package:dio/dio.dart';
import 'package:farmhouse_app/constant/api_constant.dart';

class PaymentService {
  final Dio _dio = Dio();

  /// Creates a payment order
  /// Requires [verificationId], [transactionId], and [userId]
Future<Map<String, dynamic>> createPayment({
  required String slotId,
  required String farmId,
  required String transactionId,
  required String userId,
}) async {
  try {
    final payload = {
      "farmhouseId": farmId,
      "slotId": slotId,
      "transactionId": transactionId,
      "userId": userId,
    };

    // ✅ PRINT PAYLOAD
    print("📤 PAYMENT PAYLOAD:");
    print(payload);

    final Response response = await _dio.post(
      ApiConstants.payment,
      data: payload,
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    // ✅ PRINT RESPONSE
    print("📥 PAYMENT RESPONSE STATUS:");
    print(response.statusCode);

    print("📥 PAYMENT RESPONSE BODY:");
    print(response.data);

    return response.data;
  } on DioException catch (e) {
    print("❌ PAYMENT ERROR:");
    print(e.response?.data ?? e.message);

    if (e.response != null) {
      throw Exception(e.response?.data["message"] ?? "Payment failed");
    }
    throw Exception("Network error: ${e.message}");
  }
}

}