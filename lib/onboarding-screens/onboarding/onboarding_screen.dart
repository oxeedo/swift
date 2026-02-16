import 'package:cardieone/theme.dart';
import 'package:flutter/material.dart';
import 'package:cardieone/login/login_screen.dart';
import 'package:cardieone/onboarding-screens/onboarding/get_started_page1.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content column
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance,
                          color: Colors.white, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        'Swift Pay Bank',
                        style:
                            AppTheme.headingLarge.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.06),
                // This SizedBox reserves space for the phone image in the stack
                const SizedBox(height: 120),
              ],
            ),
            // Phone mockup image (centered, floating above the card)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/phone_img.png',
                  fit: BoxFit.contain,
                  height: 460,
                ),
              ),
            ),
            // Bottom card
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: 310,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Mobile banking the world \n loves.',
                      style: AppTheme.headingLarge.copyWith(
                        color: AppTheme.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Get sending, spending and saving with \n your contactless card.',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 42),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.primaryBlue,
                              side:
                                  const BorderSide(color: AppTheme.primaryBlue),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GetStartedPage1()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Get Started'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
