import 'package:flutter/material.dart';
import '../../theme.dart';
import 'additional_info_page.dart';

class RecreatePasscodePage extends StatefulWidget {
  final String passcode;
  const RecreatePasscodePage({Key? key, required this.passcode}) : super(key: key);

  @override
  State<RecreatePasscodePage> createState() => _RecreatePasscodePageState();
}

class _RecreatePasscodePageState extends State<RecreatePasscodePage> {
  final List<String> _repeatPasscode = [];
  String? _error;
  bool _isLoading = false;

  void _onKeyTap(String value) {
    if (_repeatPasscode.length < 4 && !_isLoading) {
      setState(() {
        _repeatPasscode.add(value);
        _error = null;
      });
      if (_repeatPasscode.length == 4) {
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 1), _validatePasscode);
      }
    }
  }

  void _onBackspace() {
    if (_repeatPasscode.isNotEmpty && !_isLoading) {
      setState(() {
        _repeatPasscode.removeLast();
        _error = null;
      });
    }
  }

  void _validatePasscode() {
    final repeated = _repeatPasscode.join();
    if (repeated == widget.passcode) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdditionalInfoPage(),
        ),
      );
    } else {
      setState(() {
        _error = 'Passcodes do not match. Please try again.';
        _repeatPasscode.clear();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                        'Step 3/5',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[300],
                    color: AppTheme.primaryBlue,
                    minHeight: 2,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Repeat your passcode',
                    style: AppTheme.headingLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This will be used for logging in and access your app, so please don\'t share it with anyone.',
                    style: AppTheme.bodySmall.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[400]!),
                          color: index < _repeatPasscode.length ? Colors.blue : Colors.transparent,
                        ),
                      ),
                    )),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var row in [
                          ['1', '2', '3'],
                          ['4', '5', '6'],
                          ['7', '8', '9'],
                          ['', '0', '<'],
                        ])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: row.map((label) {
                                if (label == '') {
                                  return const SizedBox(width: 64);
                                } else if (label == '<') {
                                  return _KeypadButton(
                                    icon: Icons.backspace_outlined,
                                    onTap: _onBackspace,
                                  );
                                } else {
                                  return _KeypadButton(
                                    label: label,
                                    onTap: () => _onKeyTap(label),
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  const _KeypadButton({Key? key, this.label, this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 28, color: Colors.black54)
              : Text(
                  label ?? '',
                  style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
} 