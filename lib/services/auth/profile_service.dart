import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ProfileService {
  static const String baseUrl = "http://31.97.206.144:5124/api";

  // Get Profile
  Future<Map<String, dynamic>> getProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/getprofile/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      print('response status code for get profile ${response.statusCode}');
      print('response bodyyyyyyyyyyyy  for get profile ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }

  // Update Profile
  Future<Map<String, dynamic>> updateProfile({
    required String userId,
    String? fullName,
    String? username,
    String? gender,
    String? phoneNumber,
    String? email,
    File? profileImage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/auth/$userId/update'),
      );

      // Add text fields
      if (fullName != null) request.fields['fullName'] = fullName;
      if (username != null) request.fields['username'] = username;
      if (gender != null) request.fields['gender'] = gender;
      if (phoneNumber != null) request.fields['phoneNumber'] = phoneNumber;
      if (email != null) request.fields['email'] = email;

      // Add profile image if provided
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', profileImage.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('response update profile ${response.statusCode}');
      print('response bodyyyyyyyyyyyy  for update prpfile ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}
