import 'package:flutter/material.dart';
import '../../theme.dart';
import 'verify_details_page.dart';

class AdditionalInfoPage extends StatefulWidget {
  const AdditionalInfoPage({Key? key}) : super(key: key);

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _isLoading = false;

  bool get _isFormValid {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _dobController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_onTextChanged);
    _lastNameController.addListener(_onTextChanged);
    _dobController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_onTextChanged);
    _lastNameController.removeListener(_onTextChanged);
    _dobController.removeListener(_onTextChanged);
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
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
                    'Step 4/5',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.8, // 4/5 steps
                backgroundColor: Colors.grey[300],
                color: AppTheme.primaryBlue,
                minHeight: 2,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Just a little bit more about yourself',
                        style: AppTheme.headingLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We need some additional information from you to secure your account.',
                        style: AppTheme.bodySmall.copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _dobController,
                        decoration: const InputDecoration(
                          hintText: 'Date of birth (YYYY-MM-DD)',
                          border: UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 180),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline, size: 20, color: Colors.grey[500]),
                          const SizedBox(width: 8),
                          Text(
                            'Your information is secured with encryption.',
                            style: AppTheme.bodySmall.copyWith(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFormValid && !_isLoading ? AppTheme.primaryBlue : const Color(0xFFD6E6F5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            disabledBackgroundColor: const Color(0xFFD6E6F5),
                          ),
                          onPressed: _isFormValid && !_isLoading
                              ? () async {
                                  setState(() => _isLoading = true);
                                  await Future.delayed(const Duration(seconds: 2));
                                  setState(() => _isLoading = false);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const VerifyDetailsPage(),
                                    ),
                                  );
                                }
                              : null,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 