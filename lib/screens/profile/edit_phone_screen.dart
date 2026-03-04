import '../../core/common_dependencies.dart';
import '../auth/verification_code_screen.dart';

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
            children: [
              const Text(
                'ادخل رقم الجوال الجديد',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _phoneController,
                borderRadius: 30,
                height: 45,
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
              const SizedBox(height: 20),
              CustomButton(text: 'ارسال', onPressed: _handleSend),
            ],
          ),
        ),
      ),
    );
  }
}
