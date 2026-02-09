import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class BookingService {
  Future<Map<String, dynamic>> bookFarmhouse({
    required String farmhouseId,
    required String userId,
    required String date,
    required String label,
    required String timing,
  }) 
  async {
    try {
      final url = ApiConstants.bookfarmhouse.replaceAll(
        'farmhouseId',
        farmhouseId,
      );

      final payload = {
        "farmhouseId":farmhouseId,
        "userId": userId,
        "date": date,
        "label": label,
        "timing": timing,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      final data = jsonDecode(response.body);

      print(
        'Response status code for booking farmhouse ${response.statusCode}',
      );
      print(
        'Response bodyyyyyyyyyyyyyyyyyyy for booking farmhouse ${response.body}',
      );

if (response.statusCode == 200 || response.statusCode == 201) {
  return data; // return full API response
} else {
  return {
    'success': false,
    'message': data['message'] ?? 'Booking failed',
  };
}

    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }
}
