import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:farmhouse_app/views/models/user_model.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phoneNumber": phoneNumber,
          "password": password,
        }),
      );

      print('🔹 Login status code: ${response.statusCode}');
      print('🔹 Login response body: ${response.body}');

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (data["success"] == true) {
        final userJson = data["user"] as Map<String, dynamic>;

        final user = UserModel(
          id: userJson["_id"] as String,
          firstName: userJson["firstName"] as String,
          lastName: userJson["lastName"] as String,
          email: userJson["email"] as String,
          phoneNumber: userJson["phoneNumber"] as String,
        );

        // Save user locally
        await SharedPrefs.saveUser(user);

        return {
          'success': true,
          'user': user,
          'message': 'Login successful',
        };
      } else {
        // Return backend error message
        return {
          'success': false,
          'user': null,
          'message': data['message'] as String? ?? 'Invalid credentials',
        };
      }
    } catch (e) {
      print("❌ Login error: $e");
      return {
        'success': false,
        'user': null,
        'message': 'Network error. Please try again.',
      };
    }
  }
}