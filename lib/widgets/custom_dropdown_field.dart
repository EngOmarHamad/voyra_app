import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyra_app/core/app_theme.dart';

class CustomDropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontFamily: GoogleFonts.cairo().fontFamily,
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
