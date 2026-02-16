import '../../theme.dart';
import './verify_phone_page.dart';
import 'package:flutter/material.dart';

class GetStartedPage2 extends StatefulWidget {
  const GetStartedPage2({Key? key}) : super(key: key);

  @override
  State<GetStartedPage2> createState() => _GetStartedPage2State();
}

class _GetStartedPage2State extends State<GetStartedPage2> {
  String _selectedCountryCode = '+234'; // Default to Nigeria
  final TextEditingController _phoneController = TextEditingController();
  bool _isValidPhone = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhone);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_validatePhone);
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePhone() {
    setState(() {
      final phoneRegex = RegExp(r'^\d{10,}$');
      _isValidPhone = phoneRegex.hasMatch(_phoneController.text);
    });
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
              LinearProgressIndicator(
                value: 0.4,
                backgroundColor: Colors.grey[200],
                color: AppTheme.primaryBlue,
                minHeight: 3,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What's your mobile\nnumber?",
                        style: AppTheme.headingLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "We'll use this as your Swift Pay account number.",
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Country',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 6),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(
                                      0xFFBDBDBD), // Same as default underline
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: const [
                                  DropdownMenuItem(
                                    value: '+234',
                                    child: Row(
                                      children: [
                                        Text('🇳🇬'),
                                        SizedBox(width: 8),
                                        Text('+234')
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: '+1',
                                    child: Row(
                                      children: [
                                        Text('🇺🇸'),
                                        SizedBox(width: 8),
                                        Text('+1')
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: '+44',
                                    child: Row(
                                      children: [
                                        Text('🇬🇧'),
                                        SizedBox(width: 8),
                                        Text('+44')
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: '+91',
                                    child: Row(
                                      children: [
                                        Text('🇮🇳'),
                                        SizedBox(width: 8),
                                        Text('+91')
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCountryCode = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFBDBDBD)),
                                ),
                                counterText: '',
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 250),
                      Text(
                        'By providing your phone number, you agree that we may contact you by SMS/text messaging. Carrier messaging and data rates may apply.',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isValidPhone
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyPhonePage(),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isValidPhone
                                ? AppTheme.primaryBlue
                                : const Color(0xFFD6E6F5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            disabledBackgroundColor: const Color(0xFFD6E6F5),
                          ),
                          child: const Text(
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
