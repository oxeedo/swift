import 'package:flutter/material.dart';
import '../../theme.dart';

class CreatePasscodePage extends StatelessWidget {
  const CreatePasscodePage({Key? key}) : super(key: key);

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
                    'Step 3/5',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Progress bar
              LinearProgressIndicator(
                value: 0.6, // 3/5 steps
                backgroundColor: Colors.grey[300],
                color: AppTheme.primaryBlue,
                minHeight: 2,
              ),
              const SizedBox(height: 24),
              Text(
                'Create your passcode',
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
              // Passcode dots
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
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 40),
              // Keypad
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
                                onTap: () {},
                              );
                            } else {
                              return _KeypadButton(
                                label: label,
                                onTap: () {},
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