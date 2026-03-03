import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'package:voyra_app/core/app_theme.dart';

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
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'أضافة حساب بنكي',
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
              validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _bankNameController,
              label: 'اسم البنك',
              validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _ibanController,
              label: 'رقم الايبان',
              validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _accountNumberController,
              label: 'رقم الحساب',
              validator: (v) => v?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
            const SizedBox(height: 32),
            CustomButton(text: 'حفظ', onPressed: _handleSave),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
