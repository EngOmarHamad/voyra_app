import 'package:flutter/material.dart';
import 'order_item.dart';

// ─── حالات الطلب ─────────────────────────────────────────────────────────────
enum OrderStatus {
  newOrder('جديد', Color(0xFFE3F2FD), Color(0xFF2196F3)),
  preparing('قيد التحضير', Color(0xFFFFF3E0), Color(0xFFFF9800)),
  onTheWay('في الطريق إليك', Color(0xFFF3E5F5), Color(0xFF9C27B0)),
  delivered('تم التوصيل', Color(0xFFE8F5E9), Color(0xFF4CAF50)),
  cancelled('ملغي', Color(0xFFFFEBEE), Color(0xFFF44336));

  final String label;
  final Color backgroundColor;
  final Color textColor;

  const OrderStatus(this.label, this.backgroundColor, this.textColor);
}

// ─── طرق الدفع ───────────────────────────────────────────────────────────────
enum PaymentMethod {
  wallet('المحفظة'),
  creditCard('بطاقة ائتمانية'),
  cash('نقداً');

  final String label;
  const PaymentMethod(this.label);
}

// ─── نموذج الطلب الكامل ──────────────────────────────────────────────────────
class Order {
  final String id;
  final String orderNumber;
  final DateTime date;
  final OrderStatus status;

  // بيانات المطعم
  final String restaurantName;
  final String restaurantImageUrl;

  // وجبات الطلب
  final List<OrderItem> items;

  // بيانات الدفع
  final PaymentMethod paymentMethod;
  final double deliveryFee;
  final double tax;
  final double adminFee;

  // بيانات الإلغاء (اختيارية)
  final String? cancelReason;
  final DateTime? cancelDate;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.restaurantName,
    required this.restaurantImageUrl,
    required this.items,
    required this.paymentMethod,
    required this.deliveryFee,
    required this.tax,
    required this.adminFee,
    this.cancelReason,
    this.cancelDate,
  });

  // ── حسابات مشتقة ─────────────────────────────────────────────────────────

  /// مجموع أسعار الوجبات
  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  /// الإجمالي الكلي
  double get grandTotal => subtotal + deliveryFee + tax + adminFee;

  /// الاسم المعروض للطلب في قائمة الطلبات
  /// يأخذ اسم أول وجبة + عدد الوجبات الإضافية
  String get displayTitle {
    if (items.isEmpty) return 'طلب بدون وجبات';
    if (items.length == 1) return items.first.name;
    return '${items.first.name} +${items.length - 1}';
  }

  /// السعر الإجمالي بصيغة قابلة للعرض
  String get formattedGrandTotal => '${grandTotal.toStringAsFixed(0)} ريال';

  /// سعر الإجمالي الفرعي بصيغة قابلة للعرض
  String get formattedSubtotal => '${subtotal.toStringAsFixed(0)} ريال';

  String get formattedDeliveryFee => '${deliveryFee.toStringAsFixed(0)} ريال';

  String get formattedTax => '${tax.toStringAsFixed(0)} ريال';

  String get formattedAdminFee => '${adminFee.toStringAsFixed(0)} ريال';
}
