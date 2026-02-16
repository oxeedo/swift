import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isPrimary;
  final bool isLoading;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isPrimary,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF8B5CF6) : Colors.white,
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF374151),
          side: isPrimary 
              ? null 
              : const BorderSide(color: Color(0xFFD1D5DB), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isPrimary ? Colors.white : const Color(0xFF374151),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isPrimary ? Colors.white : const Color(0xFF374151),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
