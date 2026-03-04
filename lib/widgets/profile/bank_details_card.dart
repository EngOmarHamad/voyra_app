import '../../core/common_dependencies.dart';

class BankDetailsCard extends StatelessWidget {
  final String accountHolder;
  final String bankName;
  final String iban;
  final String accountNumber;
  final VoidCallback onEditTap;

  const BankDetailsCard({
    super.key,
    required this.accountHolder,
    required this.bankName,
    required this.iban,
    required this.accountNumber,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface, // تأكد من تعريف AppColors
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر الأول: صاحب الحساب + أيقونة التعديل
          _buildDetailRow(
            label: 'اسم صاحب الحساب',
            value: accountHolder,
            trailing: GestureDetector(
              onTap: onEditTap,
              child: Icon(
                FontAwesomeIcons.penToSquare,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // البنك
          _buildDetailRow(label: 'اسم البنك', value: bankName),
          const SizedBox(height: 12),

          // الآيبان
          _buildDetailRow(label: 'رقم الايبان', value: iban),
          const SizedBox(height: 12),

          // رقم الحساب
          _buildDetailRow(label: 'رقم الحساب', value: accountNumber),
        ],
      ),
    );
  }

  // ميثود داخلية لبناء الأسطر لتقليل تكرار الكود
  Widget _buildDetailRow({
    required String label,
    required String value,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 14,
                color: const Color(0xFF333333),
              ),
              children: [
                TextSpan(
                  text: '$label : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}
