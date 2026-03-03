import 'package:intl/intl.dart' as intl;
import '../../core/common_dependencies.dart';
import '../../screens/restaurants/all_reviews_screen.dart';
import 'restaurant_section_header.dart';
import 'restaurant_empty_state.dart';
import 'restaurant_star_rating.dart';
import 'review_card.dart';

class RestaurantReviewsSection extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantReviewsSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    // حساب عدد كل تقييم من 1 الى 5
    Map<int, int> ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    double total = 0;

    for (var review in restaurant.reviewsList) {
      int r = review.rating.round();
      if (ratingCounts.containsKey(r)) {
        ratingCounts[r] = ratingCounts[r]! + 1;
        total += r;
      }
    }

    int totalReviews = restaurant.reviewsList.length;
    double average = totalReviews == 0 ? 0 : total / totalReviews;
    final formatted = intl.NumberFormat.decimalPattern().format(totalReviews);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantSectionHeader(
            title: 'آراء العملاء',
            onSeeAll: restaurant.reviewsList.length > 3
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllReviewsScreen(
                          reviews: restaurant.reviewsList,
                          restaurantName: restaurant.name,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          if (restaurant.reviewsList.isEmpty)
            const RestaurantEmptyState(
              message: "لم يكتب أحد مراجعة بعد.. كن أول من يشارك تجربته!",
              icon: Icons.rate_review_outlined,
            )
          else ...[
            /// ⭐ المتوسط + البارات
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(5, (index) {
                      int star = index + 1;
                      int count = ratingCounts[star] ?? 0;
                      double percent = totalReviews == 0
                          ? 0
                          : count / totalReviews;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: percent,
                                  minHeight: 5,
                                  backgroundColor: const Color(0xFFCECECE),
                                  valueColor: const AlwaysStoppedAnimation(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "$star",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      average.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RestaurantStarRating(rating: average),
                    const SizedBox(height: 6),
                    Text(
                      "$formatted تقييم",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// 🔹 التعليقات الفردية
            Column(
              children: restaurant.reviewsList.take(3).map((review) {
                return ReviewCard(review: review);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
