import '../core/common_dependencies.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // تم التعديل ليكون قابلاً للعدم
  final Color? backgroundColor;
  final Color? clientTextColor;
  final bool isOutlined;
  final bool isLoading; // إضافة خاصية التحميل

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, // أزلت required لتسهيل حالة التعطيل
    this.backgroundColor,
    this.clientTextColor,
    this.isOutlined = false,
    this.isLoading = false, // القيمة الافتراضية
  });

  @override
  Widget build(BuildContext context) {
    // تحديد الدالة التي ستنفذ: إذا كان هناك تحميل، نمرر null لتعطيل الزر
    final VoidCallback? action = isLoading ? null : onPressed;

    if (isOutlined) {
      return OutlinedButton(
        onPressed: action,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          foregroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        child: _buildChild(),
      );
    }

    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: clientTextColor ?? AppColors.surface,
        disabledBackgroundColor: (backgroundColor ?? AppColors.primary)
            .withValues(alpha: 0.6),
        minimumSize: const Size(
          double.infinity,
          50,
        ), // لتوحيد الحجم مع Outlined
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ).copyWith(elevation: WidgetStateProperty.all(0)),
      child: _buildChild(),
    );
  }

  // ميثود داخلية لاختيار ما سيظهر داخل الزر (نص أم تحميل)
  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    return Text(text);
  }
}
