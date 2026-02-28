import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';
import 'package:voyra_app/screens/auth/forgot_password_screen.dart';
import 'package:voyra_app/screens/auth/sign_up_screen.dart';
import 'package:voyra_app/widgets/auth_layout.dart';
import 'package:voyra_app/widgets/custom_button.dart';
import 'package:voyra_app/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        children: [
          _buildTabs(context),
          const SizedBox(height: 30),
          const CustomTextField(
            label: 'رقم الجوال',
            hint: '5xxxxxxxx',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 15),
          const CustomTextField(
            label: 'كلمة المرور',
            obscureText: true,
            suffixIcon: Icon(Icons.visibility_off),
          ),
          const SizedBox(height: 10),
          _buildRememberForgot(),
          const SizedBox(height: 25),
          CustomButton(text: "تسجيل الدخول", onPressed: () {}),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignUpScreen()),
            ),
            child: const Text(
              "تسجيل حساب جديد",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Expanded(child: _tabButton("تسجيل الدخول", true, () {})),
          Expanded(
            child: _tabButton("تسجيل", false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: active ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _rememberMe = v!),
            ),
            const Text('تذكرني'),
          ],
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
          ),
          child: const Text(
            'نسيت كلمة المرور',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
