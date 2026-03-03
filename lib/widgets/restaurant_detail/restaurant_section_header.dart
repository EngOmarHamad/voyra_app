import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';

class RestaurantSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const RestaurantSectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "عرض الكل",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: AppColors.primary,
                    size: 10,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
