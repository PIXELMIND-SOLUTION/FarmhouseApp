import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Changed return type from UserModel? to Map<String, dynamic>?
  Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmpassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "confirmPassword": confirmpassword,
        }),
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      final data = jsonDecode(response.body);

      // ✅ Always return backend data
      return data;
    } catch (e) {
      print("Register Error: $e");
      return {"success": false, "message": "Something went wrong"};
    }
  }
}
