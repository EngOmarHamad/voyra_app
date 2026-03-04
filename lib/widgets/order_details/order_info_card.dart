import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../custom_text.dart';

class OrderInfoCard extends StatelessWidget {
  final Order order;
  const OrderInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CustomText(
                    'رقم الطلب',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    order.orderNumber,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: order.status.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  order.status.label,
                  fontSize: 10,
                  color: order.status.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomText(
                'تاريخ الطلب',
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 4),
              CustomText(
                '${order.date.day}/${order.date.month}/${order.date.year}  ${order.date.hour}:${order.date.minute.toString().padLeft(2, '0')}',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
