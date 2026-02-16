import '../../theme.dart';
import 'recreate_passcode_page.dart';
import 'package:flutter/material.dart';
import '../../dashboard/dashboard_page.dart';

class CreatePasscodePage extends StatefulWidget {
  final bool fromLogin;
  const CreatePasscodePage({Key? key, this.fromLogin = false})
      : super(key: key);

  @override
  State<CreatePasscodePage> createState() => _CreatePasscodePageState();
}

class _CreatePasscodePageState extends State<CreatePasscodePage> {
  final List<String> _passcode = [];

  void _onKeyTap(String value) {
    if (_passcode.length < 4) {
      setState(() {
        _passcode.add(value);
      });
      if (_passcode.length == 4) {
        Future.delayed(const Duration(milliseconds: 150), () {
          if (widget.fromLogin) {
            // If coming from login, go directly to dashboard
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            );
          } else {
            // If from onboarding, continue to recreate passcode page
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    RecreatePasscodePage(passcode: _passcode.join()),
              ),
            );
          }
        });
      }
    }
  }

  void _onBackspace() {
    if (_passcode.isNotEmpty) {
      setState(() {
        _passcode.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Top section with back button (if not from login)
                if (!widget.fromLogin) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 20, color: Colors.black54),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Text(
                        'Step 3/5',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.6, // 3/5 steps
                    backgroundColor: Colors.grey[300],
                    color: AppTheme.primaryBlue,
                    minHeight: 2,
                  ),
                  const SizedBox(height: 40),
                ] else ...[
                  const SizedBox(height: 60),
                ],

                // Title - centered and clean
                Text(
                  widget.fromLogin
                      ? 'Enter your passcode'
                      : 'Create your passcode',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 80),

                // Passcode dots - larger and centered
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index < _passcode.length
                                    ? AppTheme.primaryBlue
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                            ),
                          )),
                ),

                const Spacer(),

                // Keypad - clean and minimal
                Column(
                  children: [
                    for (var row in [
                      ['1', '2', '3'],
                      ['4', '5', '6'],
                      ['7', '8', '9'],
                      ['', '0', '<'],
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: row.map((label) {
                            if (label == '') {
                              return const SizedBox(width: 80);
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

                const SizedBox(height: 60),
              ],
            ),
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

  const _KeypadButton({Key? key, this.label, this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.transparent, // No background like in the image
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 28,
                  color: Colors.black87,
                )
              : Text(
                  label ?? '',
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.black87,
                    fontWeight: FontWeight.w300, // Lighter weight like in image
                  ),
                ),
        ),
      ),
    );
  }
}