import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../core/app_theme.dart';
import '../../widgets/auth_layout.dart';
import '../../widgets/custom_button.dart';
import 'reset_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 59;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _canResend = true;
            _timer?.cancel();
          }
        });
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      setState(() {
        _secondsRemaining = 59;
        _canResend = false;
      });
      _startTimer();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'تم الإرسال',
        text: 'تم إعادة إرسال كود التفعيل بنجاح',
        confirmBtnText: 'موافق',
        confirmBtnColor: AppColors.primary,
      );
    }
  }

  String _formatTime() {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  bool _isCodeComplete() {
    return _controllers.every((c) => c.text.isNotEmpty);
  }

  void _validateAndSubmit() {
    if (_isCodeComplete()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'خطأ',
        text: 'يرجى إدخال الكود كاملاً المكون من 4 أرقام',
        confirmBtnText: 'حاول مجدداً',
        confirmBtnColor: AppColors.primary,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'كود التفعيل',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'من فضلك أدخل كود التفعيل المرسل إليك عبر البريد الإلكتروني',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 35),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildCodeBox(index)),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 20,
                color: _secondsRemaining > 0 ? AppColors.primary : Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                _formatTime(),
                style: TextStyle(
                  color: _secondsRemaining > 0
                      ? AppColors.primary
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          CustomButton(text: 'تأكيد', onPressed: _validateAndSubmit),
          const SizedBox(height: 15),
          TextButton(
            onPressed: _canResend ? _resendCode : null,
            child: Text(
              'لم يصلك الكود؟ إعادة إرسال',
              style: TextStyle(
                color: _canResend ? AppColors.primary : Colors.grey,
                fontWeight: FontWeight.bold,
                decoration: _canResend
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: _controllers[index].text.isNotEmpty
              ? AppColors.primary
              : AppColors.border,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {});
            if (value.isNotEmpty && index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }
}
