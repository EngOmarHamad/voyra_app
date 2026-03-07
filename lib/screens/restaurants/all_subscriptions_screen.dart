import '../../core/common_dependencies.dart';
import '../../widgets/restaurant_detail/subscription_card.dart';

class AllSubscriptionsScreen extends StatelessWidget {
  final List<SubscriptionModel> subscriptions;
  final String restaurantName;

  const AllSubscriptionsScreen({
    super.key,
    required this.subscriptions,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "اشتراكات $restaurantName",
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subscriptions.length,
          itemBuilder: (context, index) {
            final sub = subscriptions[index];
            return SubscriptionCard(subscription: sub);
          },
        ),
      ),
    );
  }
}
