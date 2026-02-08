import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class ForgotService {
  // =============================
  // 1️⃣ Forgot Password (Send OTP)
  // =============================
  Future<Map<String, dynamic>> forgotPassword(String phoneNumber) async {
    try {
      final url = Uri.parse(ApiConstants.forgotpassword);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phoneNumber": phoneNumber}),
      );

      print('📞 Forgot Password API Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          "success": data["success"] ?? true,
          "message": data["message"] ?? "OTP sent successfully",
          "token": data["token"],
        };
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Invalid phone number",
        };
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Phone number not registered",
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Failed to send OTP. Please try again.",
        };
      }
    } catch (e) {
      print('❌ Forgot Password Error: $e');
      return {
        "success": false,
        "message": "Network error. Please check your connection.",
      };
    }
  }

  // =============================
  // 2️⃣ Verify OTP
  // =============================
  Future<Map<String, dynamic>> verifyOtp({
    required String token,
    required String otp,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.verifyOtp);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"token": token, "otp": otp}),
      );

      print('🔐 Verify OTP API Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          "success": data["success"] ?? true,
          "message": data["message"] ?? "OTP verified successfully",
        };
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Invalid OTP",
        };
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "OTP expired or invalid",
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Failed to verify OTP. Please try again.",
        };
      }
    } catch (e) {
      print('❌ Verify OTP Error: $e');
      return {
        "success": false,
        "message": "Network error. Please check your connection.",
      };
    }
  }

  // =============================
  // 3️⃣ Reset Password
  // =============================
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final url = Uri.parse(ApiConstants.resetpassword);
      print('🔒 RToken: $token');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "token": token,
          "newPassword": newPassword,
          "confirmNewPassword": confirmPassword,
        }),
      );

      print('🔒 Reset Password API Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          "success": data["success"] ?? true,
          "message": data["message"] ?? "Password reset successfully",
        };
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Invalid password or passwords do not match",
        };
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Session expired. Please start again.",
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data["message"] ?? "Failed to reset password. Please try again.",
        };
      }
    } catch (e) {
      print('❌ Reset Password Error: $e');
      return {
        "success": false,
        "message": "Network error. Please check your connection.",
      };
    }
  }
}