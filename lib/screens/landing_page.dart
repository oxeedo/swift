import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_logo.dart';
import '../widgets/auth_button.dart';
import 'email_auth_screen.dart';
import 'phone_auth_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo Section
                  const CustomLogo(),
                  
                  const SizedBox(height: 32),
                  
                  // Tagline
                  const Text(
                    'THE FUTURE\nOF FIRST\nIMPRESSIONS.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: 1.2,
                      height: 1.1,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Authentication Buttons
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Continue with Mail Button (Primary)
                        AuthButton(
                          text: 'Continue with mail',
                          icon: Icons.email_outlined,
                          isPrimary: true,
                          isLoading: authProvider.isLoading,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmailAuthScreen(),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Continue with Phone Number Button
                        AuthButton(
                          text: 'Continue with phone number',
                          icon: Icons.phone_android_outlined,
                          isPrimary: false,
                          isLoading: authProvider.isLoading,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PhoneAuthScreen(),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Continue with Google Button
                        AuthButton(
                          text: 'Continue with google',
                          icon: Icons.g_mobiledata,
                          isPrimary: false,
                          isLoading: authProvider.isLoading,
                          onPressed: () async {
                            final success = await authProvider.signInWithGoogle();
                            if (success) {
                              _showSuccessMessage('Successfully signed in with Google!');
                            } else if (authProvider.errorMessage != null) {
                              _showErrorMessage(authProvider.errorMessage!);
                            }
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Continue with Apple Button
                        AuthButton(
                          text: 'Continue with apple',
                          icon: Icons.apple,
                          isPrimary: false,
                          isLoading: authProvider.isLoading,
                          onPressed: () async {
                            final success = await authProvider.signInWithApple();
                            if (success) {
                              _showSuccessMessage('Successfully signed in with Apple!');
                            } else if (authProvider.errorMessage != null) {
                              _showErrorMessage(authProvider.errorMessage!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Footer - Login Link
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Color(0xFF6C757D),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to login screen
                            // You can implement this based on your needs
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login functionality coming soon!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              color: Color(0xFF8B5CF6),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
