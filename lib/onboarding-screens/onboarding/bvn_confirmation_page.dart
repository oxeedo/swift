import 'package:flutter/material.dart';

class BVNConfirmationPage extends StatefulWidget {
  const BVNConfirmationPage({Key? key}) : super(key: key);

  @override
  State<BVNConfirmationPage> createState() => _BVNConfirmationPageState();
}

class _BVNConfirmationPageState extends State<BVNConfirmationPage> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  bool _isOtpComplete = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  Widget _buildCodeInput(int index) {
    return SizedBox(
      width: 44,
      child: TextField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
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
            borderSide: const BorderSide(color: Color(0xFF1A73E8)),
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
                    'Step 5/5',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: 1.0,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF1A73E8),
                minHeight: 2,
              ),
              const SizedBox(height: 24),
              const Text(
                'BVN Confirmation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please enter the code we sent to **** *** 2417',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => _buildCodeInput(i)),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Didn't receive the code? Resend code",
                    style: TextStyle(
                      color: Color(0xFF1A73E8),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 13,
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
                          // Navigate to next page or show success
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isLoading
                        ? const Color(0xFFD6E6F5)
                        : (_isOtpComplete ? const Color(0xFF1A73E8) : const Color(0xFFD6E6F5)),
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
                      : const Text('Submit'),
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