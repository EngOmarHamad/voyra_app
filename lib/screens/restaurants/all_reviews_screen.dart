import 'package:intl/intl.dart' as intl;
import '../../core/common_dependencies.dart';
import '../../widgets/restaurant_detail/restaurant_star_rating.dart';
import '../../widgets/restaurant_detail/review_card.dart';

class AllReviewsScreen extends StatelessWidget {
  final List<ReviewModel> reviews;
  final String restaurantName;

  const AllReviewsScreen({
    super.key,
    required this.reviews,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    // حساب التقييمات
    Map<int, int> ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    double total = 0;
    for (var review in reviews) {
      int r = review.rating.round();
      if (ratingCounts.containsKey(r)) {
        ratingCounts[r] = ratingCounts[r]! + 1;
        total += r;
      }
    }
    int totalReviews = reviews.length;
    double average = totalReviews == 0 ? 0 : total / totalReviews;
    final formatted = intl.NumberFormat.decimalPattern().format(totalReviews);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "آراء عملاء $restaurantName",
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ملخص التقييمات
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: List.generate(5, (index) {
                          int star = 5 - index;
                          int count = ratingCounts[star] ?? 0;
                          double percent = totalReviews == 0
                              ? 0
                              : count / totalReviews;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Text(
                                  "$star",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: percent,
                                      minHeight: 6,
                                      backgroundColor: Colors.grey.shade200,
                                      valueColor: const AlwaysStoppedAnimation(
                                        AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          average.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RestaurantStarRating(rating: average, size: 18),
                        const SizedBox(height: 8),
                        Text(
                          "$formatted تقييم",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// المراجعات
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ReviewCard(review: review);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
