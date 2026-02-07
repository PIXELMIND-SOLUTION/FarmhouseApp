

import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class ForgotService {
  // =============================
  // 1️⃣ Forgot Password (Send OTP)
  // =============================
  Future<Map<String, dynamic>> forgotPassword(String phoneNumber) async {
    final url = Uri.parse(ApiConstants.forgotpassword);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phoneNumber": phoneNumber}),
    );

    print('response status code for forgotpassword ${response.statusCode}');
    print('response bodyyyy for forgot forgotpassword ${response.body}');

    return jsonDecode(response.body);
  }

  // =============================
  // 2️⃣ Verify OTP
  // =============================
  Future<Map<String, dynamic>> verifyOtp({
    required String token,
    required String otp,
  }) async {
    final url = Uri.parse(ApiConstants.verifyOtp);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": token, "otp": otp}),
    );

    print('response status code for verifyotp ${response.statusCode}');
    print('response bodyyyy for forgot verifyotp ${response.body}');
    return jsonDecode(response.body);
  }

  // =============================
  // 3️⃣ Reset Password
  // =============================
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final url = Uri.parse(ApiConstants.resetpassword);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": token,
        "newPassword": newPassword,
        "confirmNewPassword": confirmPassword,
      }),
    );
    print('response status code for resetpassword ${response.statusCode}');
    print('response bodyyyy for forgot resetpassword ${response.body}');
    return jsonDecode(response.body);
  }
}
