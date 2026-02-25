import 'package:farmhouse_app/services/auth/login_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/views/models/user_model.dart';

class LoginProvider with ChangeNotifier {
  final LoginService _authService = LoginService();

  bool isLoading = false;
  UserModel? currentUser;
  String? errorMessage;

  /// Clear error message
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  /// Load local user on app start
  Future<void> loadUser() async {
    try {
      currentUser = await SharedPrefs.getUser();
      notifyListeners();
    } catch (e) {
      print('❌ Error loading user: $e');
      currentUser = null;
      notifyListeners();
    }
  }

  /// Login function
  Future<bool> login(String phoneNumber, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.login(phoneNumber, password);

      isLoading = false;

      if (result['success'] == true && result['user'] != null) {
        currentUser = result['user'] as UserModel;
        notifyListeners();
        return true;
      } else {
        // Extract error message from backend
        errorMessage = result['message'] as String? ?? 'Login failed. Please try again.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ Login error: $e');
      isLoading = false;
      errorMessage = _parseErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

    //Guest login function

    Future<bool> guestLogin() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.guestLogin();

      isLoading = false;

      if (result['success'] == true && result['user'] != null) {
        currentUser = result['user'] as UserModel;
        notifyListeners();
        return true;
      } else {
        errorMessage = result['message'] as String? ?? 'Guest login failed. Please try again.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ Guest login error: $e');
      isLoading = false;
      errorMessage = _parseErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      currentUser = null;
      errorMessage = null;
      await SharedPrefs.clear();
      notifyListeners();
    } catch (e) {
      print('❌ Logout error: $e');
    }
  }

  /// Parse error messages
  String _parseErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Request timeout. Please try again.';
    } else if (error.toString().contains('FormatException')) {
      return 'Invalid server response. Please try again.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }
}