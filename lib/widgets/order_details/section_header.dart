import '../../core/common_dependencies.dart';
import '../../models/order_model.dart'; // تعريف Order

// ──────────────────────────
// 1️⃣ Section Header
// ──────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomText(title, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }
}

// ──────────────────────────
// 2️⃣ Detail Row
// ──────────────────────────
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(value, fontSize: 13, color: AppColors.textPrimary),
          CustomText(label, fontSize: 13, color: Colors.grey[500]),
        ],
      ),
    );
  }
}

// ──────────────────────────
// 3️⃣ Payment Details Column
// ──────────────────────────
class PaymentDetails extends StatelessWidget {
  final OrderModel order;

  const PaymentDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailRow(label: 'الاجمالي الفرعي', value: order.formattedSubtotal),
        DetailRow(label: 'سعر التوصيل', value: order.formattedDeliveryFee),
        DetailRow(label: 'الضريبة المضافة', value: order.formattedTax),
        DetailRow(label: 'نسبة الادارة', value: order.formattedAdminFee),
      ],
    );
  }
}

// ──────────────────────────
// 4️⃣ Grand Total Row
// ──────────────────────────
class GrandTotalRow extends StatelessWidget {
  final String total;

  const GrandTotalRow({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(total, fontSize: 18, fontWeight: FontWeight.bold),
        const CustomText('الاجمالي', fontSize: 16, fontWeight: FontWeight.bold),
      ],
    );
  }
}
