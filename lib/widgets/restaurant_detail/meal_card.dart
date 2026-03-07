import 'package:provider/provider.dart';

import '../../core/common_dependencies.dart';
import '../../screens/restaurants/meal_detail_screen.dart';
import '../../providers/cart_provider.dart';
import '../../models/order_item.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final double imageHeight;

  const MealCard({super.key, required this.meal, required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// صورة الوجبة
          Container(
            width: double.infinity,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(meal.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// اسم الوجبة
          Text(
            meal.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          /// السعر
          Text(
            "السعر: ${meal.price} ₪",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.primary,
            ),
          ),

          const Spacer(),

          /// الأزرار
          Row(
            children: [
              /// زر التفاصيل
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailScreen(meal: meal),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "التفاصيل",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 5),

              /// زر إضافة للسلة
              InkWell(
                onTap: () {
                  final cart = context.read<CartProvider>();

                  cart.addToCart(
                    OrderItem(
                      id: meal.name,
                      name: meal.name,
                      price: meal.price,
                      quantity: 1,
                      image: meal.image,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${meal.name} تمت إضافته للسلة"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
