import 'package:flutter/material.dart';
import '../../theme.dart';
import './get_started_page2.dart';

class GetStartedPage1 extends StatefulWidget {
  const GetStartedPage1({Key? key}) : super(key: key);

  @override
  State<GetStartedPage1> createState() => _GetStartedPage1State();
}

class _GetStartedPage1State extends State<GetStartedPage1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _termsAccepted = false;
  bool _obscurePassword = true;
  bool _isValidEmail = false;
  bool _isValidPassword = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _passwordController.removeListener(_validatePassword);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      _isValidEmail = emailRegex.hasMatch(_emailController.text);
    });
  }

  void _validatePassword() {
    setState(() {
      // Password should be at least 8 characters with at least one number
      final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
      _isValidPassword = passwordRegex.hasMatch(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Step 1/5',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 0.2,
                  backgroundColor: Colors.grey[200],
                  color: AppTheme.primaryBlue,
                  minHeight: 3,
                ),
                const SizedBox(height: 32),
                Text(
                  'Get started with your account!',
                  style: AppTheme.headingLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: const UnderlineInputBorder(),
                    suffixIcon: _isValidEmail
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const UnderlineInputBorder(),
                    helperText: 'Minimum 8 characters with at least one number',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isValidPassword)
                          const Icon(Icons.check_circle, color: Colors.green),
                        IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (val) {
                        setState(() {
                          _termsAccepted = val ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                            children: [
                              const TextSpan(
                                  text:
                                      'I have read and I understand Swift Pay Bank\'s '),
                              TextSpan(
                                text: 'Terms and conditions',
                                style: const TextStyle(
                                    color: AppTheme.primaryBlue,
                                    decoration: TextDecoration.underline),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: const TextStyle(
                                    color: AppTheme.primaryBlue,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _termsAccepted
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GetStartedPage2()),
                            );
                          }
                        : null,
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
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
