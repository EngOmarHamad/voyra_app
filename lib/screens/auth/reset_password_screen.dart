import 'package:flutter/material.dart';
import '../../widgets/auth_layout.dart'; // تأكد من المسار الصحيح للـ layout الجديد
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        children: [
          const Text(
            'إنشاء كلمة مرور جديدة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),

          const CustomTextField(
            label: 'كلمة المرور الجديدة',
            obscureText: true,
            suffixIcon: Icon(Icons.visibility_off),
          ),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'تأكيد كلمة المرور',
            obscureText: true,
            suffixIcon: Icon(Icons.visibility_off),
          ),

          const SizedBox(height: 32),
          CustomButton(
            text: 'حفظ',
            onPressed: () {
              // توجيه المستخدم لصفحة تسجيل الدخول بعد الحفظ بنجاح
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
