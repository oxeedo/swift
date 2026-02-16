import 'package:flutter/material.dart';
import 'package:cardieone/dashboard/dashboard_page.dart';

class SubmissionThankYouPage extends StatefulWidget {
  const SubmissionThankYouPage({Key? key}) : super(key: key);

  @override
  State<SubmissionThankYouPage> createState() => _SubmissionThankYouPageState();
}

class _SubmissionThankYouPageState extends State<SubmissionThankYouPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                strokeWidth: 4,
              ),
              SizedBox(height: 32),
              Text(
                'Thanks for submitting...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'This will be done in a few seconds.\nLeaving the app will restart the process.',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
