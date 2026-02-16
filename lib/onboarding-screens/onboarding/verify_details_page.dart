import 'package:flutter/material.dart';
import 'submission_thank_you_page.dart';

class VerifyDetailsPage extends StatefulWidget {
  const VerifyDetailsPage({Key? key}) : super(key: key);

  @override
  State<VerifyDetailsPage> createState() => _VerifyDetailsPageState();
}

class _VerifyDetailsPageState extends State<VerifyDetailsPage> {
  final TextEditingController _bvnController = TextEditingController();
  bool _isLoading = false;

  bool get _isBVNValid =>
      _bvnController.text.length == 10 &&
      RegExp(r'^[0-9]+$').hasMatch(_bvnController.text);

  @override
  void initState() {
    super.initState();
    _bvnController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _bvnController.dispose();
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
                color: const Color(
                    0xFF1A73E8), // Use your AppTheme.primaryBlue if available
                minHeight: 2,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Verify your details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'To verify your identity, we need you to provide your BVN.',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _bvnController,
                        decoration: const InputDecoration(
                          hintText: 'BVN',
                          border: UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          const Icon(Icons.lock_outline,
                              size: 24, color: Colors.grey),
                          const SizedBox(height: 8),
                          const Text(
                            'Your Bank Verification Number is just used for verification purposes only.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isLoading
                                    ? const Color(0xFFD6E6F5)
                                    : (_isBVNValid
                                        ? const Color(0xFF1A73E8)
                                        : const Color(0xFFD6E6F5)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              onPressed: _isBVNValid && !_isLoading
                                  ? () async {
                                      setState(() => _isLoading = true);
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      setState(() => _isLoading = false);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SubmissionThankYouPage(),
                                        ),
                                      );
                                    }
                                  : null,
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Verify BVN',
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
