import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'auth/verification_code_screen.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_formKey.currentState!.validate()) {
      // Navigate to Verification Code
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerificationCodeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل رقم الجوال')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ادخل رقم الجوال الجديد',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _phoneController,
                label: 'رقم الجوال',
                hint: '5xxxxxxxx',
                keyboardType: TextInputType.phone,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🇸🇦', style: TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم الجوال';
                  }
                  if (value.length < 9) {
                    return 'رقم الجوال غير صحيح';
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomButton(text: 'ارسال', onPressed: _handleSend),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
