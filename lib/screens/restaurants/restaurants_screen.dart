import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyra_app/models/restaurant.dart';
import 'package:voyra_app/widgets/custom_dropdown_field.dart';
import '../../core/app_theme.dart';
import '../../widgets/custom_text_field.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  String sortBy = 'الترتيب';
  String restaurantType = 'نوع المطعم';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Search and Filter Row
            Column(
              children: [
                CustomTextField(
                  hint: 'بحث',
                  prefixIcon: const Icon(Icons.search),
                  height: 40,
                  fontSize: 14,
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField(
                        value: restaurantType,
                        items: ['نوع المطعم', 'شعبي', 'إيطالي', 'شرقي'],
                        onChanged: (value) {
                          setState(() => restaurantType = value!);
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: CustomDropdownField(
                        value: sortBy,
                        items: ['الترتيب', 'الأعلى تقييم', 'الأقرب'],
                        onChanged: (value) {
                          setState(() => sortBy = value!);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Restaurants Grid
            LayoutBuilder(
              builder: (context, constraints) {
                double currentMaxExtent = 200;
                double cardWidth =
                    (constraints.maxWidth /
                    (constraints.maxWidth / currentMaxExtent).ceil());
                double dynamicRatio = cardWidth < 160 ? 0.65 : 0.78;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: dynamicRatio,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return RestaurantCard(index: index);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final int index;
  const RestaurantCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final restaurants = [
      Restaurant(
        name: 'مطعم الدجاج',
        image: 'assets/images/user.jpg',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج المشوية - 100 طبق',
      ),
      Restaurant(
        name: 'مطعم كنتاكي',
        image: 'assets/images/user.jpg',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج - 100 طبق',
      ),
      Restaurant(
        name: 'مطعم الشيف',
        image: 'assets/images/user.jpg',
        rating: 4.9,
        reviews: 100,
        dishes: 'الطعام المتنوع - 100 طبق',
      ),
      Restaurant(
        name: 'مطعم الدجاج',
        image: 'assets/images/user.jpg',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج - 100 طبق',
      ),
      Restaurant(
        name: 'مطعم كنتاكي',
        image: 'assets/images/user.jpg',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج - 100 طبق',
      ),
      Restaurant(
        name: 'مطعم الدجاج',
        image: 'assets/images/user.jpg',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج - 100 طبق',
      ),
    ];
    final restaurant = restaurants[index];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/restaurant_detail',
        arguments: restaurant.name,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // قسم اللوجو - يأخذ 40% من مساحة الكرت
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(restaurant.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
            ),

            // قسم المعلومات - يأخذ 60% من مساحة الكرت
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // يوزع العناصر عمودياً بالتساوي
                  children: [
                    // اسم المطعم
                    Text(
                      restaurant.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),

                    // التقييم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.rating}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          // لضمان عدم حدوث Overflow في حال زاد عدد المراجعات
                          child: Text(
                            '(${restaurant.reviews})',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // وصف الأطباق
                    Text(
                      restaurant.dishes,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),

                    // زر التفاصيل
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/restaurant_detail',
                          arguments: restaurant.name,
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: const BorderSide(
                            color: Color(0xFFE52D50),
                          ), // لون AppColors.primary
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'التفاصيل',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFFE52D50),
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
    );
  }
}
