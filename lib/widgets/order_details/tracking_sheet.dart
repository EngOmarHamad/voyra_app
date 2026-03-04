import '../../core/common_dependencies.dart';

class TrackingSheet extends StatelessWidget {
  const TrackingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'تتبع الطلب',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.cairo().fontFamily,
              ),
            ),
            const SizedBox(height: 24),
            _buildStep(
              Icons.check_circle_rounded,
              const Color(0xFF4CAF50),
              'تم استلام الطلب',
              'تم تأكيد طلبك بنجاح',
              true,
            ),
            _buildStep(
              Icons.check_circle_rounded,
              const Color(0xFF4CAF50),
              'قيد التحضير',
              'المطعم يحضّر طلبك',
              true,
            ),
            _buildStep(
              Icons.delivery_dining_rounded,
              const Color(0xFF9C27B0),
              'في الطريق إليك',
              'المندوب انطلق بطلبك',
              false,
              true,
            ),
            _buildStep(
              Icons.home_rounded,
              Colors.grey[400]!,
              'تم التوصيل',
              'سيصل الطلب قريباً',
              false,
              false,
              true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'إغلاق',
                  style: TextStyle(
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
    IconData icon,
    Color color,
    String title,
    String subtitle,
    bool isDone, [
    bool isActive = false,
    bool isLast = false,
  ]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: color, size: 28),
            if (!isLast)
              Container(
                width: 2,
                height: 36,
                color: isDone ? const Color(0xFF4CAF50) : Colors.grey[200],
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    color: isActive
                        ? const Color(0xFF9C27B0)
                        : isDone
                        ? AppColors.textPrimary
                        : Colors.grey[400],
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
