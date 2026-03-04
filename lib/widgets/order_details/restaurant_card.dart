import '../../core/common_dependencies.dart';
import '../../models/order.dart';

class RestaurantCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onDetailsPressed;

  const RestaurantCard({super.key, required this.order, this.onDetailsPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFfcfcfc),
        border: Border.all(color: Colors.grey[100]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  order.restaurantImageUrl,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 36,
                    height: 36,
                    color: Colors.orange[100],
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.orange,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CustomText(
                order.restaurantName,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          OutlinedButton(
            onPressed: onDetailsPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              minimumSize: const Size(0, 32),
            ),
            child: const CustomText(
              'التفاصيل',
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
