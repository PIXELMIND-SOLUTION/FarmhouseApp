

// import 'package:farmhouse_app/services/auth/forgot_service.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordProvider extends ChangeNotifier {
//   final ForgotService _authService = ForgotService();

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   String? _token;
//   String? get token => _token;

//   // =============================
//   // 1️⃣ Request OTP (Forgot Password)
//   // =============================
//   Future<bool> sendOtp(String phoneNumber) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _authService.forgotPassword(phoneNumber);

//       if (response["success"] == true) {
//         _token = response["token"]; // store the token for reset password
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // =============================
//   // 2️⃣ Verify OTP
//   // =============================
//   Future<bool> verifyOtp(String token, String otp) async {
//     if (_token == null) return false;

//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _authService.verifyOtp(
//         token: _token!,
//         otp: otp,
//       );

//       _isLoading = false;
//       notifyListeners();

//       return response["success"] ?? false;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // =============================
//   // 3️⃣ Reset Password
//   // =============================
//   Future<bool> resetPassword(
//       String newPassword, String confirmPassword) async {
//     if (_token == null) return false;

//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _authService.resetPassword(
//         token: _token!,
//         newPassword: newPassword,
//         confirmPassword: confirmPassword,
//       );

//       _isLoading = false;
//       notifyListeners();

//       return response["success"] ?? false;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }
// }














import 'package:farmhouse_app/services/auth/forgot_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final ForgotService _authService = ForgotService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  // =============================
  // 1️⃣ Request OTP (Forgot Password)
  // =============================
  Future<bool> sendOtp(String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.forgotPassword(phoneNumber);

      if (response["success"] == true) {
        _token = response["token"];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // =============================
  // 2️⃣ Verify OTP (Forgot Password Flow)
  // =============================
  Future<bool> verifyOtp(String token, String otp) async {
    if (_token == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(
        token: _token!,
        otp: otp,
      );

      _isLoading = false;
      notifyListeners();

      return response["success"] ?? false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // =============================
  // 🆕 NEW: Verify Registration OTP
  // =============================
  Future<bool> verifyRegistrationOtp(String otp, String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Verifying OTP: $otp with token: $token');
      
      final response = await _authService.verifyOtp(
        token: token,  // ✅ Use the passed token (registration token)
        otp: otp,
      );

      print('Verification response: $response');

      _isLoading = false;
      notifyListeners();

      return response["success"] ?? false;
    } catch (e) {
      print('Verification error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // =============================
  // 3️⃣ Reset Password
  // =============================
  Future<bool> resetPassword(
      String newPassword, String confirmPassword) async {
    if (_token == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.resetPassword(
        token: _token!,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      _isLoading = false;
      notifyListeners();

      return response["success"] ?? false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
