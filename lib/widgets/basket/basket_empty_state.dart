import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyra_app/core/app_theme.dart';

class BasketEmptyState extends StatelessWidget {
  const BasketEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.basketShopping,
            size: 100,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 20),
          Text(
            'سلتك فارغة حالياً',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'ابدأ بإضافة بعض الوجبات الشهية لسلتك',
            style: TextStyle(
              color: Colors.grey[500],
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              child: const Text('تسوق الآن'),
            ),
          ),
        ],
      ),
    );
  }
}
