import 'package:provider/provider.dart';
import 'package:voyra_app/core/common_dependencies.dart';
import 'package:voyra_app/providers/cart_provider.dart';

import '../../models/order_item.dart';

class MealDetailScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.meal.name,
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [const CartButton()],
        leading: const CustomBackButton(),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meal Image with Calories
                    Stack(
                      children: [
                        Image.asset(
                          widget.meal.image,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.fire,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "السعرات الحرارية للوجبة : 600 - 700 سعر حراري",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "معلومات عن الطبق:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.cairo().fontFamily,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "البرياني هو طبق أرز شهي ذو أصل هندي، يتميز بتوابله الغنية ونكهاته القوية. يتم طهيه مع الدجاج المتبل ويُقدم عادة مع الزبادي أو السلطة لإضافة لمسة انتعاش.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              height: 1.6,
                              fontFamily: GoogleFonts.cairo().fontFamily,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Notes Section
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "اترك ملاحظة",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                CustomTextField(
                                  height: null,
                                  maxLines: 4,
                                  hint: "أكتب ملاحظتك هنا",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            // Quantity Selector
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => setState(() => quantity++),
                                  ),
                                  Text(
                                    "$quantity",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() => quantity--);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Add to Cart Button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  final cart = context.read<CartProvider>();

                                  cart.addToCart(
                                    OrderItem(
                                      id: widget.meal.name,
                                      name: widget.meal.name,
                                      price: widget.meal.price,
                                      quantity: quantity,
                                      image: widget.meal.image,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${widget.meal.name} تمت إضافته للسلة",
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "أضف للسلة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
