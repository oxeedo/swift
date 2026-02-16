import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_models.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Initialize Google Sign In
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  AuthProvider() {
    _loadUserFromStorage();
  }

  // Load user from local storage
  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_data');
      if (userJson != null) {
        final userMap = Map<String, dynamic>.from(
          const JsonDecoder().convert(userJson)
        );
        _currentUser = User.fromJson(userMap);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user from storage: $e');
    }
  }

  // Save user to local storage
  Future<void> _saveUserToStorage(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = const JsonEncoder().convert(user.toJson());
      await prefs.setString('user_data', userJson);
    } catch (e) {
      print('Error saving user to storage: $e');
    }
  }

  // Clear user from storage
  Future<void> _clearUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
    } catch (e) {
      print('Error clearing user from storage: $e');
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _setError(null);
  }

  // Email Authentication
  Future<bool> signInWithEmail(String email, [String? password]) async {
    _setLoading(true);
    _setError(null);

    try {
      final request = EmailAuthRequest(email: email, password: password);
      final response = await ApiService.authenticateWithEmail(request);

      if (response.success && response.user != null) {
        _currentUser = response.user;
        await _saveUserToStorage(_currentUser!);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message ?? 'Email authentication failed');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      _setLoading(false);
      return false;
    }
  }

  // Phone Authentication - Send Code
  Future<bool> sendPhoneVerificationCode(String phoneNumber) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await ApiService.sendPhoneVerificationCode(phoneNumber);

      if (response.success) {
        _setLoading(false);
        return true;
      } else {
        _setError(response.message ?? 'Failed to send verification code');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      _setLoading(false);
      return false;
    }
  }

  // Phone Authentication - Verify Code
  Future<bool> verifyPhoneCode(String phoneNumber, String code) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await ApiService.verifyPhoneCode(phoneNumber, code);

      if (response.success && response.user != null) {
        _currentUser = response.user;
        await _saveUserToStorage(_currentUser!);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message ?? 'Invalid verification code');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      _setLoading(false);
      return false;
    }
  }

  // Google Authentication
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _setError(null);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        _setLoading(false);
        return false; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      if (googleAuth.accessToken == null) {
        _setError('Failed to get Google access token');
        _setLoading(false);
        return false;
      }

      final response = await ApiService.authenticateWithGoogle(googleAuth.accessToken!);

      if (response.success && response.user != null) {
        _currentUser = response.user;
        await _saveUserToStorage(_currentUser!);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message ?? 'Google authentication failed');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Google sign-in failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Apple Authentication
  Future<bool> signInWithApple() async {
    _setLoading(true);
    _setError(null);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        _setError('Failed to get Apple identity token');
        _setLoading(false);
        return false;
      }

      final response = await ApiService.authenticateWithApple(credential.identityToken!);

      if (response.success && response.user != null) {
        _currentUser = response.user;
        await _saveUserToStorage(_currentUser!);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message ?? 'Apple authentication failed');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Apple sign-in failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    _setLoading(true);

    try {
      // Sign out from Google if signed in
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.signOut();
      }

      // Clear local data
      _currentUser = null;
      await _clearUserFromStorage();
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError('Error signing out');
      _setLoading(false);
    }
  }
}
