import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final String? fontFamily;
  final double? height;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.fontFamily,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.textPrimary,
        fontFamily: fontFamily,
        height: height,
      ),
    );
  }
}
