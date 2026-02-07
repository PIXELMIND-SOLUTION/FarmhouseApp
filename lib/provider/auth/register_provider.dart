// import 'package:farmhouse_app/services/auth/register_service.dart';
// import 'package:farmhouse_app/utils/helper_function.dart';
// import 'package:farmhouse_app/views/models/user_model.dart';
// import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   UserModel? _user;
//   bool _loading = false;

//   UserModel? get user => _user;
//   bool get isLoading => _loading;

//   final AuthService _authService = AuthService();

//   Future<bool> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String phoneNumber,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     _loading = true;
//     notifyListeners();

//     final user = await _authService.register(
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       phoneNumber: phoneNumber,
//       password: password,
//       confirmpassword: confirmPassword
//     );

//     _loading = false;

//     if (user != null) {
//       _user = user;
//       await SharedPrefs.saveUser(user);
//       notifyListeners();
//       return true;
//     } else {
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<void> loadUserFromPrefs() async {
//     _user = await SharedPrefs.getUser();
//     notifyListeners();
//   }

//   void logout() async {
//     _user = null;
//     await SharedPrefs.clear();
//     notifyListeners();
//   }
// }











import 'package:farmhouse_app/services/auth/register_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:farmhouse_app/views/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _loading = false;

  UserModel? get user => _user;
  bool get isLoading => _loading;

  final AuthService _authService = AuthService();

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmpassword: confirmPassword
      );

      _loading = false;

      if (response != null && response['success'] == true) {
        // Get user data and token separately
        final userJson = response['user'] as Map<String, dynamic>;
        final token = response['token'] as String?;
        
        // Add token to user object
        if (token != null) {
          userJson['token'] = token;
        }
        
        // Create user model
        _user = UserModel.fromJson(userJson);
        
        await SharedPrefs.saveUser(_user!);
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Registration error: $e');
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadUserFromPrefs() async {
    _user = await SharedPrefs.getUser();
    notifyListeners();
  }

  void logout() async {
    _user = null;
    await SharedPrefs.clear();
    notifyListeners();
  }
}