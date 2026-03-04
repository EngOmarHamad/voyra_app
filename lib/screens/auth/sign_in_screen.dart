import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';
import 'package:voyra_app/screens/auth/forgot_password_screen.dart';
import 'package:voyra_app/screens/auth/sign_up_screen.dart';
import 'package:voyra_app/widgets/auth_layout.dart';
import 'package:voyra_app/widgets/custom_button.dart';
import 'package:voyra_app/widgets/custom_text_field.dart';
import 'package:quickalert/quickalert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _phoneController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'تم تسجيل الدخول بنجاح',
            confirmBtnColor: AppColors.primary,
            onConfirmBtnTap: () {
              // روح على الصفحة الرئيسية
              Navigator.pushReplacementNamed(context, '/home');
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        String message = "حدث خطأ";

        if (e.code == 'user-not-found') {
          message = 'المستخدم غير موجود';
        } else if (e.code == 'wrong-password') {
          message = 'كلمة المرور غير صحيحة';
        } else if (e.code == 'invalid-email') {
          message = 'البريد غير صالح';
        }
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: message,
            confirmBtnColor: AppColors.primary,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            _buildTabs(context),
            const SizedBox(height: 30),
            CustomTextField(
              controller: _phoneController,
              label: 'رقم الجوال',
              hint: '5xxxxxxxx',
              keyboardType: TextInputType.phone,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
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
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.mobileScreenButton,
                  size: 18,
                  color: AppColors.textSecondary,
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
            const SizedBox(height: 15),
            CustomTextField(
              controller: _passwordController,
              label: 'كلمة المرور',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: FaIcon(
                  _obscurePassword
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.lock,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            _buildRememberForgot(),
            const SizedBox(height: 25),
            CustomButton(text: "تسجيل الدخول", onPressed: _handleSignIn),
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
