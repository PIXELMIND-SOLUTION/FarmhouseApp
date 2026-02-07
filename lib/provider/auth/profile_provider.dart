// Save this file as: lib/providers/profile_provider.dart

import 'dart:io';
import 'package:farmhouse_app/services/auth/profile_service.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/views/models/user_model.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _profileData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get profileData => _profileData;

  // Get profile data
  Future<void> fetchProfile(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _profileService.getProfile(userId);
      if (response['success'] == true) {
        _profileData = response['profile'];
      } else {
        _errorMessage = 'Failed to load profile';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update profile
  Future<bool> updateProfile({
    required String userId,
    String? fullName,
    String? username,
    String? gender,
    String? phoneNumber,
    String? email,
    File? profileImage,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _profileService.updateProfile(
        userId: userId,
        fullName: fullName,
        username: username,
        gender: gender,
        phoneNumber: phoneNumber,
        email: email,
        profileImage: profileImage,
      );

      if (response['success'] == true) {
        _profileData = response['profile'];
        
        // Update shared preferences with new data
        if (fullName != null && fullName.isNotEmpty) {
          final names = fullName.split(' ');
          await SharedPrefs.saveUser(UserModel(
            id: userId,
            firstName: names.first,
            lastName: names.length > 1 ? names.sublist(1).join(' ') : '',
            email: email ?? _profileData?['email'] ?? '',
            phoneNumber: phoneNumber ?? _profileData?['phoneNumber'] ?? '',
          ));
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to update profile';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}