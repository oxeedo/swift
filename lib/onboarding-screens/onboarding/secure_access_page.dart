import '../../theme.dart';
import 'create_passcode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SecureAccessPage extends StatefulWidget {
  const SecureAccessPage({Key? key}) : super(key: key);

  @override
  State<SecureAccessPage> createState() => _SecureAccessPageState();
}

class _SecureAccessPageState extends State<SecureAccessPage> {
  void _showFaceIdDialog() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Do you want to allow "Swift Pay" to use Face ID?'),
        content:
            const Text('This allows you to login to Swift Pay using Face ID.'),
        actions: [
          CupertinoDialogAction(
            child: const Text("Don't Allow"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Future.delayed(
                  const Duration(milliseconds: 200), _showFaceIdModal);
            },
          ),
        ],
      ),
    );
  }

  void _showFaceIdModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CupertinoPopupSurface(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreatePasscodePage(),
                ),
              );
            },
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.face, size: 64, color: Colors.black54),
                  SizedBox(height: 12),
                  Text('Face ID',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ],
              ),
            ),
          ),
        ),
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
                'Secure your access',
                style: AppTheme.headingLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want to unlock and enter your Swift Pay Bank app.',
                style: AppTheme.bodySmall.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 32),
              // Face ID & Passcode option
              ListTile(
                leading:
                    Image.asset('assets/faceId.png', width: 32, height: 32),
                title: Text('Face ID & Passcode',
                    style: AppTheme.bodyLarge.copyWith(color: Colors.black)),
                onTap: _showFaceIdDialog,
                contentPadding: EdgeInsets.zero,
                shape: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              // Passcode only option
              ListTile(
                leading: const Icon(Icons.dialpad,
                    size: 32, color: AppTheme.primaryBlue),
                title: Text('Passcode only',
                    style: AppTheme.bodyLarge.copyWith(color: Colors.black)),
                onTap: () {},
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
