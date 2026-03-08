import 'package:flutter/material.dart';
import 'package:voyra_app/widgets/auth_layout.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'verification_code_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voyra_app/core/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const VerificationCodeScreen(verificationId: ''),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        key: _formKey,
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
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: _phoneController,
              label: 'رقم الجوال',
              hint: '5xxxxxxxx',
              keyboardType: TextInputType.phone,
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.mobileScreenButton,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/palestine_flag.svg",
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          '🇵🇸',
                          style: TextStyle(fontSize: 22),
                        );
                      },
                    ),
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
            const SizedBox(height: 30),
            CustomButton(text: 'إرسال كود التحقق', onPressed: _handleSend),
          ],
        ),
      ),
    );
  }
}
