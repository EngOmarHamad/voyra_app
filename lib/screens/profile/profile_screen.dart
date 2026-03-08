import 'package:provider/provider.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // استخدام listen: false ضروري داخل initState
      context.read<UserProvider>().fetchUserData();
    });
  }

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
    // نستخدم read هنا بدلاً من watch لأننا سنستخدم Selector في الأجزاء المتغيرة
    final userProvider = context.read<UserProvider>();

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
            const ProfileHeaderCard(
              imageUrl:
                  'https://media.istockphoto.com/id/1262964459/photo/nothing-is-a-magnet-for-success-like-self-confidence.jpg?s=612x612&w=0&k=20&c=1iMsY14y_8JtWA2Oeo0TCQQYe3Jio78O1Q2MxKWZQnI=',
            ),
            const SizedBox(height: 20),

            // 1. قسم البيانات الشخصية (يحدث فقط عند تغيير الاسم أو الايميل)
            Selector<UserProvider, String>(
              selector: (_, prov) =>
                  "${prov.currentUser?.name}${prov.currentUser?.email}",
              builder: (context, combinedData, _) {
                final user = userProvider.currentUser;
                return Column(
                  children: [
                    _SectionHeader(
                      title: 'بيانات الملف الشخصي',
                      action: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onAction: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _InfoCard(
                      backgroundColor: AppColors.surface,
                      children: [
                        _InfoRow(
                          label: 'الأسم',
                          value: user?.name ?? 'غير محدد',
                        ),
                        _InfoRow(
                          label: 'البريد الإلكتروني',
                          value: user?.email ?? 'غير محدد',
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 12),

            // 2. قسم الهاتف (يحدث فقط عند تغيير الهاتف)
            Selector<UserProvider, String?>(
              selector: (_, prov) => prov.currentUser?.phone,
              builder: (context, phone, _) {
                return _InfoCard(
                  backgroundColor: Colors.transparent,
                  children: [
                    _InfoRow(
                      label: 'رقم الجوال',
                      value: phone ?? 'غير محدد',
                      hasEditIcon: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditPhoneScreen(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 12),
            // كلمة المرور لا تتغير هنا، تبقى ثابتة
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

            const SizedBox(height: 30),

            // 3. 🔥 قسم البيانات البنكية (هذا ما سيحدث وحده عند إضافة حساب)
            Selector<UserProvider, dynamic>(
              selector: (_, prov) => prov.currentUser?.bankDetails,
              builder: (context, bankDetails, _) {
                return Column(
                  children: [
                    _SectionHeader(
                      title: 'البيانات البنكية',
                      action: Text(
                        bankDetails == null ? 'إضافة' : 'تعديل',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      onAction: () => _showAddBankSheet(context),
                    ),
                    const SizedBox(height: 12),
                    if (bankDetails != null)
                      BankDetailsCard(
                        accountHolder: bankDetails.accountHolder,
                        bankName: bankDetails.bankName,
                        iban: bankDetails.iban,
                        accountNumber: bankDetails.accountNumber,
                        onEditTap: () => _showAddBankSheet(context),
                      )
                    else
                      _InfoCard(
                        backgroundColor: Colors.white,
                        children: [
                          const Center(
                            child: Text(
                              "لا يوجد حساب بنكي مضاف حالياً",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
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
