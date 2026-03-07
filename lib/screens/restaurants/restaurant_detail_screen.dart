import '../../core/common_dependencies.dart';
import '../../widgets/restaurant_detail/restaurant_detail_widgets.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key, required this.restaurant});
  final RestaurantModel restaurant;
  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // محاكاة تحميل بيانات
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;

    if (isLoading) {
      return const RestaurantShimmer();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const CustomDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              RestaurantHeader(restaurant: restaurant),
              RestaurantDescription(restaurant: restaurant),
              const SizedBox(height: 15),
              RestaurantMealsSection(restaurant: restaurant),
              const SizedBox(height: 15),
              RestaurantSubscriptionsSection(restaurant: restaurant),
              const SizedBox(height: 15),
              RestaurantReviewsSection(restaurant: restaurant),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
