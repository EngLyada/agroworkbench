import 'package:agroworkbench/screens/homepages.dart';

import '../screens/Forgot_Password.dart';
import '../screens/Register.dart';
import '../screens/credentials.dart';
import 'package:agroworkbench/controllers/app_push.dart';

import 'package:agroworkbench/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Back!',
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please login to continue',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 40),

              Credentials(
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please Enter a Valid Email Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Credentials(
                label: 'Password',
                prefixIcon: Icons.lock_clock_outlined,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.off(Forgot()),
                  child: Text(
                    'Forgot Password',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymedium,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loginto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonmedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              //sign up  button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.off(RegisterScreen()),
                  child: Text('Register',
                  style: AppTextStyles.withColor(
                      AppTextStyles.bodymedium,
                     Theme.of(context).primaryColor,
                    ),
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Handle Login
  void _loginto() {
    final Auth auth = Get.find<Auth>();
    auth.login();
    Get.offAll(() => const Mainscreen());
  }
}
