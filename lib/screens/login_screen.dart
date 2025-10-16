import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_constants.dart';
import '../utils/accessibility_helper.dart';
import '../widgets/accessible_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _showOtpField = false;
  String _verificationId = '';
  int? _resendToken;

  @override
  void initState() {
    super.initState();
    // Set initial value for phone number
    _phoneController.text = '+256';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'AgroWorkbench',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Semantics(
                hint: _showOtpField 
                    ? 'Enter the 6-digit code sent to your phone' 
                    : 'Enter your phone number to continue',
                child: Text(
                  _showOtpField 
                      ? 'Enter the 6-digit code sent to your phone' 
                      : 'Enter your phone number to continue',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (!_showOtpField) ...[
                // Phone number input
                AccessibleTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: '+256 XXX XXX XXX',
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    // Value is updated through controller
                  },
                  validator: (value) {
                    if (value != null && value.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AccessibilityHelper.buildAccessibleButton(
                  onPressed: _sendOTP,
                  label: 'Send Code',
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ] else ...[
                // OTP input
                AccessibleTextField(
                  controller: _otpController,
                  label: 'Verification Code',
                  hint: 'Enter 6-digit code',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Value is updated through controller
                  },
                  validator: (value) {
                    if (value != null && value.length != 6) {
                      return 'Please enter a valid 6-digit code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AccessibilityHelper.buildAccessibleButton(
                  onPressed: _verifyOTP,
                  label: 'Verify Code',
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _resendOTP,
                  child: const Text('Resend Code'),
                ),
              ],
              const SizedBox(height: 32),
              // Guest mode option
              TextButton(
                onPressed: () {
                  // Navigate to home screen where guest can continue
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(color: Color(0xFF10B981)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    final phoneNumber = _phoneController.text.trim();
    
    if (phoneNumber.isEmpty || phoneNumber == '+256') {
      _showError('Please enter your phone number');
      return;
    }

    // Format phone number (add country code if not present)
    final formattedPhoneNumber = phoneNumber.startsWith('+')
        ? phoneNumber
        : '+256${phoneNumber.replaceAll('+256', '')}';

    try {
      // In a real app, this would send an OTP via SMS
      final success = await AuthService.sendOTP(formattedPhoneNumber);
      
      if (success) {
        setState(() {
          _showOtpField = true;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification code sent!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        _showError('Failed to send verification code');
      }
    } catch (e) {
      _showError('Error sending verification code: $e');
    }
  }

  Future<void> _verifyOTP() async {
    final otp = _otpController.text.trim();
    
    if (otp.length != 6) {
      _showError('Please enter a valid 6-digit code');
      return;
    }

    try {
      final success = await AuthService.verifyOTP(
        _phoneController.text.trim(), 
        otp
      );
      
      if (success) {
        // Navigate to home screen for role selection
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showError('Invalid verification code');
      }
    } catch (e) {
      _showError('Error verifying code: $e');
    }
  }

  Future<void> _resendOTP() async {
    _sendOTP();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}