import '../../core/common_dependencies.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  // مفتاح النموذج للتحقق من الصحة
  final _formKey = GlobalKey<FormState>();

  // وحدات التحكم للنصوص
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        // لضمان ظهور المحتوى فوق لوحة المفاتيح
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey, // ربط النموذج
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'تغيير كلمة المرور',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // كلمة المرور القديمة
            CustomTextField(
              controller: _oldPassController,
              label: 'كلمة المرور القديمة',
              obscureText: _obscureOld,
              borderRadius: 30,
              height: null, // نلغي الارتفاع الثابت للسماح بظهور رسالة الخطأ
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور القديمة';
                }
                return null;
              },
              prefixIcon: _buildLockIcon(),
              suffixIcon: _buildVisibilityIcon(_obscureOld, () {
                setState(() => _obscureOld = !_obscureOld);
              }),
            ),
            const SizedBox(height: 16),

            // كلمة المرور الجديدة
            CustomTextField(
              controller: _newPassController,
              label: 'كلمة المرور الجديدة',
              obscureText: _obscureNew,
              borderRadius: 30,
              height: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور الجديدة';
                }
                if (value.length < 6) {
                  return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                }
                return null;
              },
              prefixIcon: _buildLockIcon(),
              suffixIcon: _buildVisibilityIcon(_obscureNew, () {
                setState(() => _obscureNew = !_obscureNew);
              }),
            ),
            const SizedBox(height: 16),

            // تأكيد كلمة المرور
            CustomTextField(
              controller: _confirmPassController,
              label: 'تأكيد كلمة المرور الجديدة',
              obscureText: _obscureConfirm,
              borderRadius: 30,
              height: null,
              validator: (value) {
                if (value != _newPassController.text) {
                  return 'كلمات المرور غير متطابقة';
                }
                return null;
              },
              prefixIcon: _buildLockIcon(),
              suffixIcon: _buildVisibilityIcon(_obscureConfirm, () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              }),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: 'تأكيد',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // إذا كان الفاليديشن صحيح
                  print("كلمة المرور صحيحة، يتم الحفظ...");
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ميثود مساعدة للأيقونات لتقليل تكرار الكود
  Widget _buildLockIcon() => const UnconstrainedBox(
    child: FaIcon(
      FontAwesomeIcons.lock,
      size: 18,
      color: AppColors.textSecondary,
    ),
  );

  Widget _buildVisibilityIcon(bool isObscured, VoidCallback onTap) =>
      IconButton(
        icon: FaIcon(
          isObscured ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
          size: 18,
          color: AppColors.textSecondary,
        ),
        onPressed: onTap,
      );
}
