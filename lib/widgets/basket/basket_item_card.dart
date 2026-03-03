import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../custom_text.dart';
import '../custom_text_field.dart';
import '../../core/app_theme.dart';
import '../../models/meal.dart';

class BasketItemCard extends StatelessWidget {
  final Meal meal;
  final int quantity;
  final String note;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;
  final ValueChanged<String> onNoteChanged;

  const BasketItemCard({
    super.key,
    required this.meal,
    required this.quantity,
    required this.note,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    required this.onNoteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  meal.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const FaIcon(
                      FontAwesomeIcons.burger,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // السطر الأول: الاسم وسعر القطعة الواحدة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                meal.name,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                maxLines: 1,
                              ),
                            ),
                            CustomText(
                              '${meal.price * quantity} ريال ',
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // تعديل عرض تفصيل السعر: (الكمية × سعر الحبة = الإجمالي)
                        CustomText(
                          "$quantity × ${meal.price} ريال ",
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),

                        // أزرار التحكم والحذف
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // أزرار الزيادة والنقصان
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAEAEA).withValues(
                                  alpha: 0.5,
                                ), // استخدام اللون الرمادي الذي طلبته
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  _buildQuantityBtn(
                                    FontAwesomeIcons.plus,
                                    onAdd,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  _buildQuantityBtn(
                                    FontAwesomeIcons.minus,
                                    onRemove,
                                  ),
                                ],
                              ),
                            ),

                            // أيقونة الحذف (FontAwesome الرفيعة)
                            IconButton(
                              onPressed: onDelete,
                              icon: const FaIcon(
                                FontAwesomeIcons
                                    .trashCan, // لإصدار أرفع استخدم 'light' إذا كنت تملك الإصدار المدفوع، أو صغر الحجم
                                color: Colors
                                    .redAccent, // يفضل اللون الأحمر للحذف أو الرمادي الفاتح
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'ملاحظة',
            hint: 'أضف ملاحظاتك هنا (بدون بصل، زيادة صوص...)',
            onChanged: onNoteChanged,
            initialValue: note,
            fontSize: 13,
            maxLines: 1,
            height: 40,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: FaIcon(icon, size: 10, color: AppColors.surface),
      ),
    );
  }
}
