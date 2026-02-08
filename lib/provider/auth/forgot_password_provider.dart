import 'package:farmhouse_app/services/auth/forgot_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final ForgotService _authService = ForgotService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // =============================
  // 1️⃣ Request OTP (Forgot Password)
  // =============================
  Future<bool> sendOtp(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.forgotPassword(phoneNumber);

      if (response["success"] == true) {
        _token = response["token"];
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response["message"] ?? "Failed to send OTP. Please try again.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "An error occurred. Please check your connection and try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // =============================
  // 2️⃣ Verify OTP (Forgot Password Flow)
  // =============================
  Future<bool> verifyOtp(String otp, String token) async {
    if (_token == null) {
      _errorMessage = "Session expired. Please request OTP again.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(
        token: _token!,
        otp: otp,
      );

      if (response["success"] == true) {
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response["message"] ?? "Invalid OTP. Please try again.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "An error occurred. Please check your connection and try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // =============================
  // 🆕 Verify Registration OTP
  // =============================
  Future<bool> verifyRegistrationOtp(String otp, String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('Verifying OTP: $otp with token: $token');
      
      final response = await _authService.verifyOtp(
        token: token,  // ✅ Use the passed token (registration token)
        otp: otp,
      );

      print('Verification response: $response');

      if (response["success"] == true) {
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response["message"] ?? "Invalid OTP. Please try again.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Verification error: $e');
      _errorMessage = "An error occurred. Please check your connection and try again.";
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
    if (_token == null) {
      _errorMessage = "Session expired. Please start the process again.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.resetPassword(
        token: _token!,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response["success"] == true) {
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response["message"] ?? "Failed to reset password. Please try again.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "An error occurred. Please check your connection and try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Reset provider state
  void reset() {
    _token = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}