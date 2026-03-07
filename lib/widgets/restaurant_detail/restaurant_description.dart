import '../../core/common_dependencies.dart';
import 'restaurant_section_header.dart';
import 'restaurant_info_badge.dart';

class RestaurantDescription extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantDescription({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RestaurantSectionHeader(title: 'حول المطعم'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "نقدم لكم أفضل المأكولات المحضرة بعناية فائقة، حيث نجمع بين الأصالة والحداثة في أطباقنا المتميزة مثل ${restaurant.dishes}.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.8,
                    color: AppColors.textPrimary.withValues(alpha: 0.8),
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    RestaurantInfoBadge(
                      icon: FontAwesomeIcons.locationArrow,
                      label: "موقعنا",
                      value: "وسط المدينة، الطابق الثاني",
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 15),
                    RestaurantInfoBadge(
                      icon: FontAwesomeIcons.clock,
                      label: "الدوام",
                      value: "8:00 ص - 11:00 م",
                      color: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: restaurant.dishes.split('،').map((dish) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        dish.trim(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
