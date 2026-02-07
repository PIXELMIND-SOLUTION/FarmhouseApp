import 'package:farmhouse_app/services/auth/login_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/views/models/user_model.dart';


class LoginProvider with ChangeNotifier {
  final LoginService _authService = LoginService();

  bool isLoading = false;
  UserModel? currentUser;

  // Load local user on app start
  Future<void> loadUser() async {
    currentUser = await SharedPrefs.getUser();
    notifyListeners();
  }

  // Login function
  Future<bool> login(String phoneNumber, String password) async {
    isLoading = true;
    notifyListeners();

    final user = await _authService.login(phoneNumber, password);

    isLoading = false;

    if (user != null) {
      currentUser = user;
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    currentUser = null;
    await SharedPrefs.clear();
    notifyListeners();
  }
}
