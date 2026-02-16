import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_models.dart';
import '../config/api_config.dart';

class ApiService {
  static Map<String, String> get _headers => ApiConfig.headers;

  // Email Authentication
  static Future<AuthResponse> authenticateWithEmail(EmailAuthRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullApiUrl}/auth/email'),
        headers: _headers,
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        return AuthResponse(
          success: false,
          message: 'Email authentication failed. Please try again.',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }

  // Phone Authentication
  static Future<AuthResponse> authenticateWithPhone(PhoneAuthRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullApiUrl}/auth/phone'),
        headers: _headers,
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        return AuthResponse(
          success: false,
          message: 'Phone authentication failed. Please try again.',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }

  // Google Authentication
  static Future<AuthResponse> authenticateWithGoogle(String googleToken) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullApiUrl}/auth/google'),
        headers: _headers,
        body: json.encode({'token': googleToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        return AuthResponse(
          success: false,
          message: 'Google authentication failed. Please try again.',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }

  // Apple Authentication
  static Future<AuthResponse> authenticateWithApple(String appleToken) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullApiUrl}/auth/apple'),
        headers: _headers,
        body: json.encode({'token': appleToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        return AuthResponse(
          success: false,
          message: 'Apple authentication failed. Please try again.',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }

  // Send verification code for phone
  static Future<AuthResponse> sendPhoneVerificationCode(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullApiUrl}/auth/phone/send-code'),
        headers: _headers,
        body: json.encode({'phoneNumber': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        return AuthResponse(
          success: false,
          message: 'Failed to send verification code. Please try again.',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }

  // Verify phone code
  static Future<AuthResponse> verifyPhoneCode(String phoneNumber, String code) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullApiUrl}/auth/phone/verify'),
        headers: _headers,
        body: json.encode({
          'phoneNumber': phoneNumber,
          'verificationCode': code,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        return AuthResponse(
          success: false,
          message: 'Invalid verification code. Please try again.',
        );
      }
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error. Please check your connection.',
      );
    }
  }
}
