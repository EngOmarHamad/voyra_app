import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyra_app/core/app_theme.dart';
import 'package:voyra_app/providers/auth_provider.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final String? errorMessage = await authProvider.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (errorMessage == null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'تم تسجيل الدخول بنجاح',
          confirmBtnColor: AppColors.primary,
          confirmBtnText: "حسنا",
          onConfirmBtnTap: () {
            // روح على الصفحة الرئيسية
            Navigator.pushReplacementNamed(context, '/home');
          },
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: errorMessage,

          confirmBtnColor: AppColors.primary,
          confirmBtnText: "حسنا",
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTabs(context),
            const SizedBox(height: 30),
            CustomTextField(
              controller: _emailController,
              label: 'البريد الالكتروني',
              hint: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.envelope,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الالكتروني';
                }

                String pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                RegExp regex = RegExp(pattern);

                if (!regex.hasMatch(value)) {
                  return 'صيغة البريد الالكتروني غير صحيحة';
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
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return CustomButton(
                  text: authProvider.isLoading
                      ? "جاري تسجيل الدخول..."
                      : "تسجيل الدخول",
                  onPressed: authProvider.isLoading ? () {} : _handleSignIn,
                  backgroundColor: authProvider.isLoading
                      ? Colors.grey
                      : AppColors.primary,
                );
              },
            ),
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
