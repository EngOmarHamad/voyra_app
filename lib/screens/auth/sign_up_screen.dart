import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:voyra_app/widgets/auth_layout.dart';
import '../../core/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../static/terms_screen.dart';
import 'sign_in_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _agree = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    if (!_agree) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'يرجى الموافقة على الشروط والأحكام أولاً',
        confirmBtnColor: AppColors.primary,
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final String? errorMessage = await authProvider.signUp(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (errorMessage == null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'تم إنشاء الحساب بنجاح',
          text: 'أهلاً بك في فويرا',
          confirmBtnColor: AppColors.primary,
          onConfirmBtnTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignInScreen()),
              (route) => false,
            );
          },
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: errorMessage,
          confirmBtnColor: AppColors.primary,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTabs(context),
            const SizedBox(height: 25),
            CustomTextField(
              controller: _nameController,
              label: 'الاسم بالكامل',
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.user,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم بالكامل';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: _phoneController,
              label: 'رقم الجوال',
              hint: '5xxxxxxxx',
              keyboardType: TextInputType.phone,
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
              controller: _emailController,
              label: 'البريد الالكتروني',
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
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'يرجى إدخال بريد الكتروني صحيح';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            CustomTextField(
              controller: _passwordController,
              label: 'كلمة المرور',
              obscureText: _obscurePassword,
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.lock,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
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
            const SizedBox(height: 15),
            CustomTextField(
              controller: _confirmPasswordController,
              label: 'تأكيد كلمة المرور',
              obscureText: _obscureConfirm,
              prefixIcon: const UnconstrainedBox(
                child: FaIcon(
                  FontAwesomeIcons.lock,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                icon: FaIcon(
                  _obscureConfirm
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى تأكيد كلمة المرور';
                }
                if (value != _passwordController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Checkbox(
                  value: _agree,
                  activeColor: AppColors.primary,
                  onChanged: (v) => setState(() => _agree = v!),
                ),
                RichText(
                  text: TextSpan(
                    text: 'أوافق على ',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'الشروط والأحكام',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TermsScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return CustomButton(
                  text: authProvider.isLoading
                      ? "جاري إنشاء الحساب..."
                      : "إنشاء حساب",
                  onPressed: authProvider.isLoading ? () {} : _handleSignUp,
                  backgroundColor: authProvider.isLoading
                      ? Colors.grey
                      : AppColors.primary,
                );
              },
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
