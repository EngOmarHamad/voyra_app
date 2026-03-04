import 'package:voyra_app/core/common_dependencies.dart';

import '../../models/order.dart';

class ActionButton extends StatelessWidget {
  final Order order;
  final VoidCallback onCancel;
  final VoidCallback onPreparingCancel;
  final VoidCallback onTrack;
  final VoidCallback onRate;

  const ActionButton({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onPreparingCancel,
    required this.onTrack,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    switch (order.status) {
      case OrderStatus.newOrder:
        return CustomButton(
          text: 'إلغاء الطلب',
          onPressed: onCancel,
          backgroundColor: AppColors.primary,
        );
      case OrderStatus.preparing:
        return CustomButton(
          text: 'إلغاء الطلب',
          onPressed: onPreparingCancel,
          backgroundColor: AppColors.primary,
        );
      case OrderStatus.onTheWay:
        return CustomButton(
          text: 'تتبع الطلب',
          onPressed: onTrack,
          backgroundColor: const Color(0xFF9C27B0),
        );
      case OrderStatus.delivered:
        return CustomButton(
          text: 'تقييم الطلب',
          onPressed: onRate,
          backgroundColor: AppColors.primary,
        );
      case OrderStatus.cancelled:
        return const SizedBox.shrink();
    }
  }
}
