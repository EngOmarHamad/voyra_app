import '../../core/common_dependencies.dart';

class RestaurantInfoTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const RestaurantInfoTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.15), width: 1),
          ),
          child: Center(child: FaIcon(icon, size: 20, color: color)),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
      ],
    );
  }
}
