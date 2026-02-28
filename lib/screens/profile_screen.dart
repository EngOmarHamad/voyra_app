import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'edit_phone_screen.dart';
import '../modals/add_bank_account_sheet.dart';
import '../modals/change_password_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Avatar Section
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300',
                  ), // Placeholder
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: AppColors.surface,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Personal Data Section
          _SectionHeader(title: 'بيانات الملف الشخصي', onEdit: () {}),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const CustomTextField(
                  label: 'الأسم بالكامل',
                  initialValue: 'عبدالله الأمير',
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: 'البريد الإلكتروني',
                  initialValue: 'Example@email.com', // Placeholder
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'رقم الجوال',
                  initialValue: '+966 50 000 0000',
                  readOnly: true,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.edit_square,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditPhoneScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'كلمة المرور',
                  initialValue: '********',
                  readOnly: true,
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.edit_square,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const ChangePasswordModal(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Bank Data Section
          _SectionHeader(
            title: 'البيانات البنكية',
            actionText: 'أضافة',
            onAction: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const AddBankAccountModal(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const CustomTextField(
                  label: 'اسم صاحب الحساب',
                  initialValue: 'عبدالله الأمير',
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: 'اسم البنك',
                  initialValue: 'البنك الراجحي',
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: 'رقم الايبان',
                  initialValue: 'SA000000000000000000',
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: 'رقم الحساب',
                  initialValue: '000000000000',
                  readOnly: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              text: 'حفظ',
              onPressed: () {
                // Save logic
              },
            ),
          ),
          const SizedBox(height: 32),

          // Static Pages Section
          _SectionHeader(title: 'المزيد', onEdit: () {}),
          const SizedBox(height: 16),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onEdit;
  final String? actionText;
  final VoidCallback? onAction;

  const _SectionHeader({
    required this.title,
    this.onEdit,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (actionText != null)
            TextButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add, size: 18),
              label: Text(actionText!),
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            )
          else if (onEdit != null)
            const SizedBox.shrink(), // Or edit icon for the whole section if needed
        ],
      ),
    );
  }
}
