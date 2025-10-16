import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService {
  static const String _authTokenKey = 'auth_token';
  static const String _userKey = 'current_user';

  // Simulate phone number verification process
  static Future<bool> sendOTP(String phoneNumber) async {
    // In a real app, this would make an API call to send OTP
    // For demo purposes, we'll simulate it
    await Future.delayed(const Duration(seconds: 1));
    
    // Here you would normally send an OTP to the phone number
    // For demo purposes, we'll just return true
    return true;
  }

  // Verify the OTP
  static Future<bool> verifyOTP(String phoneNumber, String otp) async {
    // In a real app, this would verify the OTP with the backend
    // For demo purposes, we'll accept any 6-digit code
    if (otp.length == 6 && int.tryParse(otp) != null) {
      // Save user info after successful authentication
      final user = User(
        id: 'user-${DateTime.now().millisecondsSinceEpoch}',
        name: 'Demo User',
        phone: phoneNumber,
        role: UserRole.farmer, // Default to farmer
        createdAt: DateTime.now(),
      );

      await setCurrentUser(user);
      await setAuthToken('demo_token_${DateTime.now().millisecondsSinceEpoch}');
      
      return true;
    }
    
    return false;
  }

  // Register user (after OTP verification)
  static Future<void> registerUser(User user) async {
    await setCurrentUser(user);
  }

  // Login with phone number
  static Future<bool> loginWithPhone(String phoneNumber) async {
    // For demo purposes, we'll check if we already have a stored user
    final storedUser = await getCurrentUser();
    
    if (storedUser != null) {
      return true;
    }
    
    // If no stored user, we'll need to go through OTP verification
    return false;
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    
    return null;
  }

  // Set current user
  static Future<void> setCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  // Get auth token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Set auth token
  static Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userKey);
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    final user = await getCurrentUser();
    
    return token != null && user != null;
  }

  // Update user role
  static Future<void> updateUserRole(UserRole newRole) async {
    final user = await getCurrentUser();
    
    if (user != null) {
      final updatedUser = user.copyWith(role: newRole);
      await setCurrentUser(updatedUser);
    }
  }
}