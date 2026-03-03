import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/app_theme.dart';
import '../widgets/custom_button.dart';
import 'edit_phone_screen.dart';
import '../modals/add_bank_account_sheet.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showAddBankSheet(BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          "حسابي",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Avatar Section with Red Background
            Center(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Decorative background box
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                  // Avatar with border sitting on top
                  Positioned(
                    bottom: -30,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300',
                        ),
                      ),
                    ),
                  ),
                  // Camera icon overlay
                  Positioned(
                    bottom: -35,
                    left: MediaQuery.of(context).size.width * 0.45 - 60,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: const Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.black87,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // Personal Data Section
            _SectionHeader(
              title: 'بيانات الملف الشخصي',
              icon: FontAwesomeIcons.penToSquare,
              onAction: () {},
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Group 1: Name and Email
                  _InfoCard(
                    children: [
                      _InfoRow(label: 'الأسم', value: 'عبدالله الأمير'),
                      const Divider(height: 24, color: Color(0xFFF0F0F0)),
                      _InfoRow(
                        label: 'البريد الإلكتروني',
                        value: 'Example@email.com',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Group 2: Phone Number
                  _InfoCard(
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditPhoneScreen(),
                        ),
                      );
                    },
                    children: [
                      _InfoRow(
                        label: 'رقم الجوال',
                        value: '+966 50 000 0000',
                        hasEditIcon: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Group 3: Password
                  _InfoCard(
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                    children: [
                      _InfoRow(
                        label: 'كلمة المرور',
                        value: '********',
                        hasEditIcon: true,
                        obscured: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Bank Data Section
            _SectionHeader(
              title: 'البيانات البنكية',
              actionText: 'أضافة',
              onAction: () => _showAddBankSheet(context),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _InfoCard(
                onEdit: () => _showAddBankSheet(context),
                children: [
                  _InfoRow(label: 'اسم صاحب الحساب', value: 'عبدالله الأمير'),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'اسم البنك', value: 'البنك الراجحي السعودي'),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'رقم الايبان', value: 'SA000000000000000000'),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'رقم الحساب',
                    value: '000000000000',
                    hasEditIcon: true,
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;
  final IconData? icon;

  const _SectionHeader({
    required this.title,
    this.actionText,
    this.onAction,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onEdit;

  const _InfoCard({required this.children, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool hasEditIcon;
  final bool obscured;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.label,
    required this.value,
    this.hasEditIcon = false,
    this.obscured = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  // Ensure Cairo font is used
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
                children: [
                  TextSpan(
                    text: '$label : ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: obscured ? Colors.grey : const Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (hasEditIcon)
            const Icon(
              FontAwesomeIcons.penToSquare,
              color: AppColors.primary,
              size: 20,
            ),
        ],
      ),
    );
  }
}
