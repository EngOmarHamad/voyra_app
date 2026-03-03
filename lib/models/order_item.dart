import 'package:flutter/material.dart';

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

class OrderItem {
  final String id;
  final String mealName;
  final String restaurantName;
  final String price;
  final String date;
  final String imageUrl;
  final OrderStatus status;

  const OrderItem({
    required this.id,
    required this.mealName,
    required this.restaurantName,
    required this.price,
    required this.date,
    required this.imageUrl,
    required this.status,
  });
}
