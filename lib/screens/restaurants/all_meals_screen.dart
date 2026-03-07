import '../../core/common_dependencies.dart';
import '../../widgets/restaurant_detail/meal_card.dart';

class AllMealsScreen extends StatelessWidget {
  final List<MealModel> meals;
  final String restaurantName;

  const AllMealsScreen({
    super.key,
    required this.meals,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "وجبات $restaurantName",
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        leading: const CustomBackButton(),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth < 600
                  ? 2
                  : (constraints.maxWidth < 900 ? 3 : 4);

              double imageHeight = constraints.maxWidth < 600 ? 110 : 130;

              double estimatedCardHeight = imageHeight + 130;

              double itemWidth = constraints.maxWidth / crossAxisCount;
              double dynamicAspectRatio = itemWidth / estimatedCardHeight;

              return GridView.builder(
                itemCount: meals.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: dynamicAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return MealCard(meal: meal, imageHeight: imageHeight);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
