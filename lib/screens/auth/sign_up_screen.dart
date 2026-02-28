import 'package:flutter/material.dart';
import 'package:voyra_app/widgets/auth_layout.dart';
import '../../core/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _agree = false;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        children: [
          _buildTabs(context),
          const SizedBox(height: 25),
          const CustomTextField(label: 'الاسم بالكامل'),
          const SizedBox(height: 15),
          const CustomTextField(label: 'رقم الجوال', hint: '5xxxxxxxx'),
          const SizedBox(height: 15),
          const CustomTextField(label: 'البريد الالكتروني'),
          const SizedBox(height: 15),
          const CustomTextField(label: 'كلمة المرور', obscureText: true),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: _agree,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _agree = v!),
              ),
              const Text('أوافق على الشروط والأحكام'),
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(text: "إنشاء حساب", onPressed: () {}),
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
          Expanded(
            child: _tabButton("تسجيل الدخول", false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
              );
            }),
          ),
          Expanded(child: _tabButton("تسجيل", true, () {})),
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
}
