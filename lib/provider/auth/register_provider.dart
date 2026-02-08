import 'package:farmhouse_app/services/auth/register_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:farmhouse_app/views/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _loading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _loading;
  String? get errorMessage => _errorMessage;

  final AuthService _authService = AuthService();

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Register new user
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmpassword: confirmPassword,
      );

      _loading = false;

      if (response != null && response['success'] == true) {
        // Extract user data and token
        final userJson = response['user'] as Map<String, dynamic>?;
        final token = response['token'] as String?;

        if (userJson == null) {
          _errorMessage = 'Invalid response from server';
          notifyListeners();
          return false;
        }

        // Add token to user object
        if (token != null) {
          userJson['token'] = token;
        }

        // Create user model
        _user = UserModel.fromJson(userJson);

        // Save to shared preferences
        await SharedPrefs.saveUser(_user!);
        
        notifyListeners();
        return true;
      } else {
        // Handle error response
        _errorMessage = response?['message'] as String? ?? 
                       'Registration failed. Please try again.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ Registration error: $e');
      _loading = false;
      _errorMessage = _parseErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  /// Load user from shared preferences
  Future<void> loadUserFromPrefs() async {
    try {
      _user = await SharedPrefs.getUser();
      notifyListeners();
    } catch (e) {
      print('❌ Error loading user from preferences: $e');
      _user = null;
      notifyListeners();
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      _user = null;
      _errorMessage = null;
      await SharedPrefs.clear();
      notifyListeners();
    } catch (e) {
      print('❌ Error during logout: $e');
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