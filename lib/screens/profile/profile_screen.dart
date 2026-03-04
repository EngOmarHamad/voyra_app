import 'package:voyra_app/screens/profile/edit_profile_screen.dart';
import 'package:voyra_app/widgets/profile/profile_header_card.dart';

import '../../core/common_dependencies.dart';
import '../../widgets/profile/bank_details_card.dart';
import 'change_password_sheet.dart';
import 'edit_phone_screen.dart';
import 'add_bank_account_sheet.dart';

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

  void _showChangePasswordSheet(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Avatar Section with Red Background
            ProfileHeaderCard(
              imageUrl:
                  'https://www.google.com/imgres?q=profile%20picture&imgurl=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1654110455429-cf322b40a906%3Ffm%3Djpg%26q%3D60%26w%3D3000%26auto%3Dformat%26fit%3Dcrop%26ixlib%3Drb-4.1.0%26ixid%3DM3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA%253D&imgrefurl=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fprofile-picture&docid=gMlIcsQMiG-F2M&tbnid=L_Y9hpEKpUYnPM&vet=12ahUKEwjH_MbZuIaTAxULZaQEHUVJDx4QnPAOegQIGxAB..i&w=3000&h=3000&hcb=2&ved=2ahUKEwjH_MbZuIaTAxULZaQEHUVJDx4QnPAOegQIGxAB',
            ),
            const SizedBox(height: 20),

            // Personal Data Section
            _SectionHeader(
              title: 'بيانات الملف الشخصي',
              action: FaIcon(
                FontAwesomeIcons.penToSquare,
                color: AppColors.primary,
                size: 20,
              ),
              onAction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            Column(
              children: [
                // Group 1: Name and Email
                _InfoCard(
                  backgroundColor: AppColors.surface,
                  children: [
                    _InfoRow(label: 'الأسم', value: 'عبدالله الأمير'),
                    _InfoRow(
                      label: 'البريد الإلكتروني',
                      value: 'Example@email.com',
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Group 2: Phone Number
                _InfoCard(
                  backgroundColor: Colors.transparent,
                  children: [
                    _InfoRow(
                      label: 'رقم الجوال',
                      value: '+966 50 000 0000',
                      hasEditIcon: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditPhoneScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Group 3: Password
                _InfoCard(
                  backgroundColor: Colors.transparent,

                  children: [
                    _InfoRow(
                      label: 'كلمة المرور',
                      value: '********',
                      hasEditIcon: true,
                      obscured: true,
                      onTap: () => _showChangePasswordSheet(context),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Bank Data Section
            _SectionHeader(
              title: 'البيانات البنكية',
              action: Text(
                'أضافة',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              onAction: () => _showAddBankSheet(context),
            ),
            const SizedBox(height: 12),

            BankDetailsCard(
              accountHolder: 'عبدالله الأمير',
              bankName: 'البنك الراجحي السعودي',
              iban: 'SA000000000000000000',
              accountNumber: '000000000000',
              onEditTap: () => _showAddBankSheet(context),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;
  final VoidCallback? onAction;

  const _SectionHeader({required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),

        if (action != null) GestureDetector(onTap: onAction, child: action),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  final Color? backgroundColor;

  const _InfoCard({required this.children, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
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
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 14,
                color: Color(0xFF333333),
              ),
              children: [
                TextSpan(
                  text: '$label : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: GoogleFonts.cairo().fontFamily,

                    color: obscured ? Colors.grey : const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasEditIcon)
          IconButton(
            onPressed: onTap,
            icon: Icon(
              FontAwesomeIcons.penToSquare,
              color: AppColors.primary,
              size: 20,
            ),
          ),
      ],
    );
  }
}
