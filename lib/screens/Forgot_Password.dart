import 'package:agroworkbench/utils/app_textstyles.dart';

import '../screens/login.dart';
import '../screens/credentials.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '';

class Forgot extends StatelessWidget {
  Forgot({super.key});
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Reset Password',
              style: AppTextStyles.withColor(
                AppTextStyles.h1,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),

            Text(
              'Enter your Email address to recover your Password',
              style: AppTextStyles.withColor(
                AppTextStyles.bodylarge,
                Theme.of(context).textTheme.bodyLarge!.color!,
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

            //button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => 

                  Dialogbox(context),
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Request for Reset Link',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonmedium,
                    Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
           Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Back to Login ?',
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
    );
  }

  //Dialog box

  void Dialogbox (BuildContext context){
    Get.dialog(
      AlertDialog(
        title: Text(
          'Alert'
        ),
        content: Text(
          'OTP sent to your phone use it to login with your account',
          style: AppTextStyles.buttonmedium,
        ),
        actions: [
          TextButton(
            onPressed: ()=> Get.back(),
            child: Text(
              'Ok',
              style: AppTextStyles.withColor(
                    AppTextStyles.buttonmedium,
                    Theme.of(context).primaryColor,
                  ),              
              ),
            ),
        ],
      ),
    );
    
  }
}
