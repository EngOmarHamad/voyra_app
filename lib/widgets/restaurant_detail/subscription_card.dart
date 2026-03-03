import '../../core/common_dependencies.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Subscription Title
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(text: 'اسم الاشتراك : '),
                    TextSpan(
                      text: subscription.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Duration Tag (Blue)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  subscription.duration,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 6),
          // Info Row (Meals and Price)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Meals Count
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontSize: 13,
                  ),
                  children: [
                    const TextSpan(text: 'عدد الوجبات : '),
                    TextSpan(
                      text: '${subscription.mealsCount} وجبات',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Price
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontSize: 13,
                  ),
                  children: [
                    const TextSpan(text: 'السعر: '),
                    TextSpan(
                      text: '${subscription.price} ₪',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (subscription.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            // Description Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الوصف :',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    subscription.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
