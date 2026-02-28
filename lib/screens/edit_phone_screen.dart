import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'auth/verification_code_screen.dart';

class EditPhoneScreen extends StatelessWidget {
  const EditPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل رقم الجوال')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ادخل رقم الجوال الجديد',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              label: 'رقم الجوال',
              hint: '5xxxxxxxx',
              keyboardType: TextInputType.phone,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/800px-Flag_of_Saudi_Arabia.svg.png',
                  width: 24,
                  height: 16,
                ), // Flag placeholder
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'ارسال',
              onPressed: () {
                // Navigate to Verification Code
                showDialog(
                  context: context,
                  builder: (context) => const VerificationCodeDialog(),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
