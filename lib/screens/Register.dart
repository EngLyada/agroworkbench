
import 'package:agroworkbench/screens/credentials.dart';
import 'package:agroworkbench/screens/homepages.dart';
import 'package:agroworkbench/screens/login.dart';
import 'package:agroworkbench/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
 const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Return to Login
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Create Account',
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Sign Up to get started',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),

              const SizedBox(height: 40),

              Credentials(
                label: 'Full name',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                controller: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

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

              Credentials(
                label: 'Confirm Password',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _confirm,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Name';
                  }
                  if (value != _password.text) {
                    return 'Passwords Do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(() => const Mainscreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonlarge,
                      Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account ?',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.off(Login()),
                  child: Text('Login',
                  style: AppTextStyles.withColor(
                      AppTextStyles.buttonmedium,
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
}
