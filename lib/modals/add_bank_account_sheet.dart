import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'package:voyra_app/core/app_theme.dart';

class AddBankAccountModal extends StatelessWidget {
  const AddBankAccountModal({super.key});

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
                icon: const Icon(Icons.close_rounded, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const CustomTextField(label: 'إسم صاحب الحساب'),
          const SizedBox(height: 16),
          const CustomTextField(label: 'اسم البنك'),
          const SizedBox(height: 16),
          const CustomTextField(label: 'رقم الايبان'),
          const SizedBox(height: 16),
          const CustomTextField(label: 'رقم الحساب'),
          const SizedBox(height: 32),
          CustomButton(
            text: 'حفظ',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
