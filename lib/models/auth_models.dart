class User {
  final String id;
  final String email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final AuthProvider provider;

  User({
    required this.id,
    required this.email,
    this.phoneNumber,
    this.displayName,
    this.photoUrl,
    required this.provider,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      provider: AuthProvider.values.firstWhere(
        (e) => e.toString() == 'AuthProvider.${json['provider']}',
        orElse: () => AuthProvider.email,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'provider': provider.name,
    };
  }
}

enum AuthProvider {
  email,
  phone,
  google,
  apple,
}

class AuthResponse {
  final bool success;
  final String? message;
  final User? user;
  final String? token;

  AuthResponse({
    required this.success,
    this.message,
    this.user,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}

class EmailAuthRequest {
  final String email;
  final String? password;

  EmailAuthRequest({
    required this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class PhoneAuthRequest {
  final String phoneNumber;
  final String? verificationCode;

  PhoneAuthRequest({
    required this.phoneNumber,
    this.verificationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'verificationCode': verificationCode,
    };
  }
}
