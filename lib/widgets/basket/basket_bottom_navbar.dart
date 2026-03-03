import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';

class BasketBottomNavbar extends StatelessWidget {
  final VoidCallback onCheckout;

  const BasketBottomNavbar({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 20),
      child: ElevatedButton(
        onPressed: onCheckout,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'إتمام الشراء',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            const FaIcon(FontAwesomeIcons.chevronLeft, size: 14),
          ],
        ),
      ),
    );
  }
}
