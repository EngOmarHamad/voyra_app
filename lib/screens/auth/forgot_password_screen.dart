import 'package:flutter/material.dart';
import 'package:voyra_app/widgets/auth_layout.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        children: [
          const Text(
            'نسيت كلمة المرور ؟',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'أدخل رقم جوالك لإرسال كود التفعيل',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          const CustomTextField(label: 'رقم الجوال', hint: '5xxxxxxxx'),
          const SizedBox(height: 30),
          CustomButton(
            text: 'إرسال كود التحقق',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const VerificationCodeDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
