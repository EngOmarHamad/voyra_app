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

  bool _isSaving = false; // حالة التحميل

  @override
  void dispose() {
    _nameController.dispose();
    _bankNameController.dispose();
    _ibanController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final bank = context.read<UserProvider>().currentUser?.bankDetails;
    if (bank != null) {
      _nameController.text = bank.accountHolder;
      _bankNameController.text = bank.bankName;
      _ibanController.text = bank.iban;
      _accountNumberController.text = bank.accountNumber;
    }
  }

  // الدالة المعدلة للربط مع الفايربيز
  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      // تجميع البيانات في Map
      BankModel bankData = BankModel(
        accountHolder: _nameController.text.trim(),
        bankName: _bankNameController.text.trim(),
        iban: _ibanController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
      );
      // استدعاء الدالة الموجودة في الـ UserProvider
      bool success = await context.read<UserProvider>().updateBankDetails(
        bankData,
      );

      if (mounted) {
        setState(() => _isSaving = false);
        if (success) {
          // إغلاق المودال والرجوع مع رسالة نجاح
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم حفظ الحساب البنكي بنجاح")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("حدث خطأ أثناء الحفظ، حاول ثانية")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
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

              CustomTextField(
                controller: _nameController,
                label: 'إسم صاحب الحساب',
                borderRadius: 30,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.user),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _bankNameController,
                label: 'اسم البنك',
                borderRadius: 30,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.buildingColumns),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _ibanController,
                label: 'رقم الايبان',
                borderRadius: 30,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.idCard),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _accountNumberController,
                label: 'رقم الحساب',
                borderRadius: 30,
                prefixIcon: _buildPrefixIcon(FontAwesomeIcons.hashtag),
                validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
              ),

              const SizedBox(height: 32),

              _isSaving
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: 'حفظ التعديلات', onPressed: _handleSave),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon(IconData icon) {
    return UnconstrainedBox(
      child: FaIcon(icon, size: 16, color: AppColors.textSecondary),
    );
  }
}
