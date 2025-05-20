import 'package:flutter/material.dart';
import '../../theme.dart';
import 'secure_access_page.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final FocusNode _focusNode = FocusNode();
  bool _isOtpComplete = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to check OTP completion
    for (var controller in _controllers) {
      controller.addListener(_checkOtpCompletion);
    }
  }

  void _checkOtpCompletion() {
    final isComplete = _controllers.every((controller) => controller.text.length == 1);
    if (isComplete != _isOtpComplete) {
      setState(() {
        _isOtpComplete = isComplete;
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.removeListener(_checkOtpCompletion);
      c.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildCodeInput(int index) {
    return SizedBox(
      width: 44,
      child: TextField(
        controller: _controllers[index],
        focusNode: index == 0 ? _focusNode : null,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTheme.headingLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.primaryBlue),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onChanged: (val) {
          if (val.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    'Step 2/5',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Verify your phone number',
                style: AppTheme.headingLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Enter the 6-digit code we texted to you at',
                    style: AppTheme.bodySmall.copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    '+234 8085472417', // TODO: Pass actual phone number
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      'Edit number',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => _buildCodeInput(i)),
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Didn't receive the code? Resend code",
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_isOtpComplete && !_isLoading)
                      ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SecureAccessPage(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_isOtpComplete && !_isLoading)
                        ? AppTheme.primaryBlue
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('Verify'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
} 