import '../../core/common_dependencies.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false; // لإظهار مؤشر تحميل أثناء الإرسال

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // void _handleSend() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() => _isLoading = true);

  //     try {
  //       final newPhone = _phoneController.text.trim();
  //       // تأكد من إضافة رمز الدولة إذا لم يكن موجوداً في الحقل
  //       final fullPhoneNumber = "+970$newPhone";

  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: fullPhoneNumber,
  //         verificationCompleted: (PhoneAuthCredential credential) async {
  //           // في بعض الأجهزة (Android) يتم التحقق تلقائياً
  //           // يمكنك هنا استدعاء دالة التحديث مباشرة في الـ Provider
  //           await context.read<UserProvider>().updatePhoneNumber(
  //             fullPhoneNumber,
  //           );
  //         },
  //         verificationFailed: (FirebaseAuthException e) {
  //           setState(() => _isLoading = false);
  //           String message = "فشل التحقق $e";
  //           if (e.code == 'invalid-phone-number') {
  //             message = "رقم الجوال غير صحيح";
  //           }
  //           if (e.code == 'too-many-requests') {
  //             message = "محاولات كثيرة، حاول لاحقاً";
  //           }

  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text(message), backgroundColor: Colors.red),
  //           );
  //         },
  //         codeSent: (String verificationId, int? resendToken) {
  //           setState(() => _isLoading = false);

  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => VerificationCodeScreen(
  //                 phoneNumber: fullPhoneNumber,
  //                 verificationId: verificationId,
  //                 isUpdatingPhone: true,
  //               ),
  //             ),
  //           );
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {},
  //       );
  //     } catch (e) {
  //       setState(() => _isLoading = false);
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text("خطأ غير متوقع: $e")));
  //     }
  //   }
  // }
  void _handleSend() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final newPhone = _phoneController.text.trim();
        final fullPhoneNumber = "+970$newPhone";

        // تحديث مباشر في Firestore دون إرسال كود
        bool success = await context.read<UserProvider>().updatePhoneNumber(
          fullPhoneNumber,
        );

        if (mounted) {
          setState(() => _isLoading = false);
          if (success) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: "تم تحديث رقم الجوال بنجاح",
              confirmBtnText: "موافق",
              confirmBtnColor: AppColors.primary,
              onConfirmBtnTap: () => Navigator.pop(context),
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("فشل تحديث الرقم")));
          }
        }
      } catch (e) {
        setState(() => _isLoading = false);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("خطأ: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'تعديل رقم الجوال',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'سيتم إرسال رمز تحقق لرقم الجوال الجديد للتأكد من ملكيتك له',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              CustomTextField(
                controller: _phoneController,
                borderRadius: 30,
                height: 55, // زيادة الطول قليلاً لراحة العين
                label: 'رقم الجوال الجديد',
                hint: '5xxxxxxxx',
                keyboardType: TextInputType.phone,
                suffixIcon: Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    '970+', // مفتاح الدولة ثابت أو اجعله اختيارياً
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                  if (!RegExp(r'^5[0-9]{8}$').hasMatch(value)) {
                    return 'يرجى إدخال رقم صحيح يبدأ بـ 5 ومكون من 9 أرقام';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: "حفظ التغييرات", onPressed: _handleSend),
            ],
          ),
        ),
      ),
    );
  }
}
