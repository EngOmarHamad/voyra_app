import '../../core/common_dependencies.dart';
import '../../models/order_model.dart';
import 'section_header.dart';

class CancellationSection extends StatelessWidget {
  final OrderModel order;

  const CancellationSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'سبب الإلغاء'),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabelValue(
                  label: 'تاريخ الإلغاء :',
                  value: order.cancelDate != null
                      ? '${order.cancelDate!.day}/${order.cancelDate!.month}/${order.cancelDate!.year}'
                      : '—',
                ),
                const SizedBox(height: 10),
                _buildLabelValue(
                  label: 'سبب الإلغاء :',
                  value: order.cancelReason ?? 'لم يتم تحديد سبب',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelValue({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cairo().fontFamily,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontFamily: GoogleFonts.cairo().fontFamily,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
