import 'package:flutter/material.dart';
import 'order_item.dart';

/// ─── حالات الطلب ─────────────────────────────────────────────────────────
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

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OrderStatus.newOrder,
    );
  }
}

/// ─── طرق الدفع ───────────────────────────────────────────────────────────
enum PaymentMethod {
  wallet('المحفظة'),
  creditCard('بطاقة ائتمانية'),
  cash('نقداً');

  final String label;

  const PaymentMethod(this.label);

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PaymentMethod.cash,
    );
  }
}

/// ─── نموذج الطلب ─────────────────────────────────────────────────────────
class OrderModel {
  final String id;
  final String userId;
  final String orderNumber;
  final DateTime createdAt;
  final OrderStatus status;

  /// بيانات المطعم
  final String restaurantName;
  final String restaurantImageUrl;

  /// عناصر الطلب
  final List<OrderItem> items;

  /// الدفع
  final PaymentMethod paymentMethod;

  final double deliveryFee;
  final double tax;
  final double adminFee;

  /// الإلغاء
  final String? cancelReason;
  final DateTime? cancelDate;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.createdAt,
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

  /// ───────────────── الحسابات ─────────────────

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get grandTotal => subtotal + deliveryFee + tax + adminFee;

  String get displayTitle {
    if (items.isEmpty) return 'طلب بدون وجبات';
    if (items.length == 1) return items.first.name;
    return '${items.first.name} +${items.length - 1}';
  }

  String get formattedGrandTotal => '${grandTotal.toStringAsFixed(0)} ريال';

  /// ───────────────── Firebase ─────────────────

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "orderNumber": orderNumber,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "status": status.name,
      "restaurantName": restaurantName,
      "restaurantImageUrl": restaurantImageUrl,
      "items": items.map((e) => e.toMap()).toList(),
      "paymentMethod": paymentMethod.name,
      "deliveryFee": deliveryFee,
      "tax": tax,
      "adminFee": adminFee,
      "cancelReason": cancelReason,
      "cancelDate": cancelDate?.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map["id"],
      userId: map["userId"],
      orderNumber: map["orderNumber"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map["createdAt"]),
      status: OrderStatus.fromString(map["status"]),
      restaurantName: map["restaurantName"],
      restaurantImageUrl: map["restaurantImageUrl"],
      items: (map["items"] as List).map((e) => OrderItem.fromMap(e)).toList(),
      paymentMethod: PaymentMethod.fromString(map["paymentMethod"]),
      deliveryFee: (map["deliveryFee"] ?? 0).toDouble(),
      tax: (map["tax"] ?? 0).toDouble(),
      adminFee: (map["adminFee"] ?? 0).toDouble(),
      cancelReason: map["cancelReason"],
      cancelDate: map["cancelDate"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["cancelDate"])
          : null,
    );
  }
  String get formattedSubtotal => '${subtotal.toStringAsFixed(0)} ريال';
  String get formattedDeliveryFee => '${deliveryFee.toStringAsFixed(0)} ريال';
  String get formattedTax => '${tax.toStringAsFixed(0)} ريال';
  String get formattedAdminFee => '${adminFee.toStringAsFixed(0)} ريال';

  /// تعديل الطلب بسهولة
  OrderModel copyWith({
    OrderStatus? status,
    String? cancelReason,
    DateTime? cancelDate,
  }) {
    return OrderModel(
      id: id,
      userId: userId,
      orderNumber: orderNumber,
      createdAt: createdAt,
      status: status ?? this.status,
      restaurantName: restaurantName,
      restaurantImageUrl: restaurantImageUrl,
      items: items,
      paymentMethod: paymentMethod,
      deliveryFee: deliveryFee,
      tax: tax,
      adminFee: adminFee,
      cancelReason: cancelReason ?? this.cancelReason,
      cancelDate: cancelDate ?? this.cancelDate,
    );
  }
}
