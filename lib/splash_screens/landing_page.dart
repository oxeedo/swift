import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light gray background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Logo Section
              Center(
                child: Column(
                  children: [
                    // Logo with overlapping shapes
                    Container(
                      width: 80,
                      height: 80,
                      child: Stack(
                        children: [
                          // Blue rectangle
                          Positioned(
                            left: 0,
                            top: 20,
                            child: Container(
                              width: 30,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4285F4).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          // Pink rectangle
                          Positioned(
                            right: 0,
                            top: 20,
                            child: Container(
                              width: 30,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEA4335).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          // Green rectangle
                          Positioned(
                            left: 25,
                            bottom: 0,
                            child: Container(
                              width: 30,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF34A853).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Tagline
                    const Text(
                      'THE FUTURE OF\nFIRST IMPRESSIONS.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A365D),
                        letterSpacing: 0.5,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Authentication Buttons
              Column(
                children: [
                  // Continue with mail (Primary button)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle email authentication
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6), // Purple
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.email_outlined, size: 20),
                      label: const Text(
                        'Continue with mail',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Continue with phone number
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle phone authentication
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF374151),
                        side: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.phone_outlined, size: 20),
                      label: const Text(
                        'Continue with phone number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Continue with Google
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle Google authentication
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF374151),
                        side: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://developers.google.com/identity/images/g-logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      label: const Text(
                        'Continue with google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Continue with Apple
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle Apple authentication
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF374151),
                        side: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.apple, size: 20),
                      label: const Text(
                        'Continue with apple',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(flex: 1),
              
              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle login navigation
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Color(0xFF8B5CF6), // Purple
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
