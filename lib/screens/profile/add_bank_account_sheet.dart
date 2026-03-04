import '../../core/common_dependencies.dart';

class AddBankAccountModal extends StatefulWidget {
  const AddBankAccountModal({super.key});

  @override
  State<AddBankAccountModal> createState() => _AddBankAccountModalState();
}

class _AddBankAccountModalState extends State<AddBankAccountModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _ibanController = TextEditingController();
  final _accountNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bankNameController.dispose();
    _ibanController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        // لضمان عدم تداخل لوحة المفاتيح مع الحقول
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
        key: _formKey,
        child: SingleChildScrollView(
          // أضفنا سكرول للحماية في الشاشات الصغيرة
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'إضافة حساب بنكي',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // إسم صاحب الحساب
              CustomTextField(
                controller: _nameController,
                label: 'إسم صاحب الحساب',
                borderRadius: 30, // لجعل الحقل بيضاوي
                height: null, // للسماح بظهور رسالة الخطأ
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.user),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),

              // اسم البنك
              CustomTextField(
                controller: _bankNameController,
                label: 'اسم البنك',
                borderRadius: 30,
                height: null,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.buildingColumns),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),

              // رقم الايبان
              CustomTextField(
                controller: _ibanController,
                label: 'رقم الايبان',
                borderRadius: 30,
                height: null,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.idCard),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),

              // رقم الحساب
              CustomTextField(
                controller: _accountNumberController,
                label: 'رقم الحساب',
                borderRadius: 30,
                height: null,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.hashtag),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),

              const SizedBox(height: 32),
              CustomButton(text: 'حفظ', onPressed: _handleSave),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ميثود مساعدة لبناء الأيقونة بشكل موحد
  Widget _buildPrefixIcon(IconData icon) {
    return UnconstrainedBox(
      child: FaIcon(icon, size: 16, color: AppColors.textSecondary),
    );
  }
}
