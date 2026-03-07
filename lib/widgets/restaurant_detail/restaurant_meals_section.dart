import '../../core/common_dependencies.dart';
import '../../screens/restaurants/all_meals_screen.dart';
import 'restaurant_section_header.dart';
import 'restaurant_empty_state.dart';
import 'meal_card.dart';

class RestaurantMealsSection extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantMealsSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantSectionHeader(
            title: 'قائمة الوجبات',
            onSeeAll: restaurant.meals.length > 4
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllMealsScreen(
                          meals: restaurant.meals,
                          restaurantName: restaurant.name,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(height: 10),
          if (restaurant.meals.isEmpty)
            const RestaurantEmptyState(
              message: "لا توجد وجبات حالياً",
              icon: FontAwesomeIcons.utensils,
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600
                    ? 2
                    : (constraints.maxWidth < 900 ? 3 : 4);

                double imageHeight = constraints.maxWidth < 600 ? 110 : 130;

                double estimatedCardHeight = imageHeight + 130;

                double itemWidth = constraints.maxWidth / crossAxisCount;
                double dynamicAspectRatio = itemWidth / estimatedCardHeight;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurant.meals.length > 4
                      ? 4
                      : restaurant.meals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio:
                        dynamicAspectRatio, // التناسب الآن محسوب بدقة
                  ),
                  itemBuilder: (_, index) {
                    final meal = restaurant.meals[index];
                    return MealCard(meal: meal, imageHeight: imageHeight);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
