import 'dart:async';
import 'package:quickalert/quickalert.dart';
import '../../core/common_dependencies.dart';
import '../../providers/user_provider.dart';
import 'reset_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String? phoneNumber;
  final bool isUpdatingPhone;
  final String verificationId;

  const VerificationCodeScreen({
    super.key,
    this.phoneNumber,
    this.isUpdatingPhone = false,
    required this.verificationId,
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  // ملاحظة: Firebase يتطلب 6 أرقام للتحقق من الهاتف
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 59;
  bool _canResend = false;
  bool _isLoading = false;

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

  // دالة التحقق الأساسية
  void _validateAndSubmit() async {
    if (_isCodeComplete()) {
      setState(() => _isLoading = true);

      String smsCode = _controllers.map((c) => c.text).join();

      try {
        // 1. إنشاء الـ Credential
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: smsCode,
        );

        if (widget.isUpdatingPhone) {
          // 2. تحديث الرقم في Firebase Auth للحساب الحالي
          await FirebaseAuth.instance.currentUser!.updatePhoneNumber(
            credential,
          );
          if (!mounted) return;
          // 3. تحديث الرقم في قاعدة بيانات Firestore للمزامنة
          await context.read<UserProvider>().updateUserFields({
            'phone': widget.phoneNumber,
          });

          await _handlePhoneUpdateSuccess();
        } else {
          // حالة نسيان كلمة المرور (تحتاج لتسجيل الدخول بهذا الـ credential)
          await FirebaseAuth.instance.signInWithCredential(credential);

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen(),
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        String msg = 'كود التحقق غير صحيح';
        if (e.code == 'session-expired') {
          msg = 'انتهت صلاحية الكود، أعد الإرسال';
        }
        _showError(msg);
      } catch (e) {
        _showError('حدث خطأ غير متوقع: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      _showError('يرجى إدخال الكود كاملاً (6 أرقام)');
    }
  }

  bool _isCodeComplete() => _controllers.every((c) => c.text.isNotEmpty);

  Future<void> _handlePhoneUpdateSuccess() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'تم بنجاح',
      text: 'تم تحديث رقم الجوال المرتبط بحسابك',
      confirmBtnText: 'موافق',
      onConfirmBtnTap: () {
        // العودة لشاشة البروفايل مباشرة
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  void _showError(String msg) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'خطأ',
      text: msg,
      confirmBtnText: 'حاول مجدداً',
      confirmBtnColor: AppColors.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.isUpdatingPhone ? 'تحديث الهاتف' : 'تأكيد الرمز',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'أدخل الرمز المكون من 6 أرقام المرسل إلى\n${widget.phoneNumber}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),

          // حقول الإدخال
          Directionality(
            textDirection: TextDirection.ltr,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildCodeBox(index),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          _buildTimerRow(),
          const SizedBox(height: 30),

          _isLoading
              ? const CircularProgressIndicator()
              : CustomButton(text: 'تحقق الآن', onPressed: _validateAndSubmit),

          const SizedBox(height: 20),
          _buildResendButton(),
        ],
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _controllers[index].text.isNotEmpty
              ? AppColors.primary
              : AppColors.border,
          width: 2,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          setState(() {});
          // التحقق التلقائي عند اكتمال الأرقام
          if (_isCodeComplete()) _validateAndSubmit();
        },
      ),
    );
  }

  Widget _buildTimerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.timer_outlined, size: 18, color: AppColors.primary),
        const SizedBox(width: 5),
        Text(
          "${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: _canResend
          ? () {
              /* أضف دالة إعادة الإرسال هنا */
            }
          : null,
      child: Text(
        'إعادة إرسال الكود',
        style: TextStyle(color: _canResend ? AppColors.primary : Colors.grey),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }
}
