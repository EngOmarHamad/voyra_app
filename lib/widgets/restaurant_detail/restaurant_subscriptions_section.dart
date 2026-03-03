import '../../core/common_dependencies.dart';
import '../../screens/restaurants/all_subscriptions_screen.dart';
import 'restaurant_section_header.dart';
import 'restaurant_empty_state.dart';
import 'subscription_card.dart';

class RestaurantSubscriptionsSection extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantSubscriptionsSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantSectionHeader(
            title: 'باقات الاشتراك المتاحة',
            onSeeAll: restaurant.subscriptions.length > 3
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllSubscriptionsScreen(
                          subscriptions: restaurant.subscriptions,
                          restaurantName: restaurant.name,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(height: 10),
          if (restaurant.subscriptions.isEmpty)
            const RestaurantEmptyState(
              message: "لا تتوفر باقات اشتراك شهرية لهذا المطعم حالياً.",
              icon: Icons.card_membership_rounded,
            )
          else
            Column(
              children: restaurant.subscriptions.take(3).map((sub) {
                return SubscriptionCard(subscription: sub);
              }).toList(),
            ),
        ],
      ),
    );
  }
}
