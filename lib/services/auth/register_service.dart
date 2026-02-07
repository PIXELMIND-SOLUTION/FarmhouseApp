// import 'dart:convert';
// import 'package:farmhouse_app/constant/api_constant.dart';
// import 'package:farmhouse_app/views/models/user_model.dart';
// import 'package:http/http.dart' as http;

// class AuthService {
//   Future<UserModel?> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String phoneNumber,
//     required String password,
//     required String confirmpassword,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(ApiConstants.register),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "firstName": firstName,
//           "lastName": lastName,
//           "email": email,
//           "phoneNumber": phoneNumber,
//           "password": password,
//           "confirmPassword":confirmpassword
//         }),
//       );
        
//         print('response status code for registration ${response.statusCode}');
//         print('response bodyyyyyyyyyyyyy for registration ${response.body}');


//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data["success"] == true) {
//           return UserModel.fromJson(data["user"]);
//         }
//       }

//       return null;
//     } catch (e) {
//       print("Register Error: $e");
//       return null;
//     }
//   }
// }












import 'dart:convert';
import 'package:farmhouse_app/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Changed return type from UserModel? to Map<String, dynamic>?
  Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmpassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "confirmPassword": confirmpassword
        }),
      );
        
      print('Response status code for registration: ${response.statusCode}');
      print('Response body for registration: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          // Return the entire response instead of just the user
          return data;
        }
      }

      return null;
    } catch (e) {
      print("Register Error: $e");
      return null;
    }
  }
}