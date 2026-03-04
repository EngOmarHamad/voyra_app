import '../../core/common_dependencies.dart';
import '../../models/order.dart';

class PaymentMethodRow extends StatelessWidget {
  final PaymentMethod paymentMethod;

  const PaymentMethodRow({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (paymentMethod == PaymentMethod.creditCard) {
      icon = FontAwesomeIcons.creditCard;
    } else if (paymentMethod == PaymentMethod.cash) {
      icon = FontAwesomeIcons.moneyBill;
    } else {
      icon = FontAwesomeIcons.wallet;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(
          'طريقة الدفع',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        Row(
          children: [
            CustomText(
              paymentMethod.label,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(width: 8),
            FaIcon(icon, size: 16, color: Colors.grey[600]),
          ],
        ),
      ],
    );
  }
}
