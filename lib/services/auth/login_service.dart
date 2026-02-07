import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:farmhouse_app/views/models/user_model.dart';

class LoginService {
  Future<UserModel?> login(String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phoneNumber": phoneNumber, "password": password}),
      );
      print('response status code for login ${response.statusCode}');
      print('response bodyyyyyyyyyyyy for login ${response.body}');

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        final userJson = data["user"];

        final user = UserModel(
          id: userJson["_id"],
          firstName: userJson["firstName"],
          lastName: userJson["lastName"],
          email: userJson["email"],
          phoneNumber: userJson["phoneNumber"],
        );

        // Save user locally
        await SharedPrefs.saveUser(user);

        return user;
      } else {
        return null;
      }
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }
}
