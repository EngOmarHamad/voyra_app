import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/app_theme.dart';
import '../screens/cart/basket_screen.dart';

class CartButton extends StatelessWidget {
  final int count;
  final Color? iconColor;

  const CartButton({super.key, this.count = 4, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.cartShopping,
            color: iconColor ?? AppColors.primary,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BasketScreen()),
            );
          },
        ),
        Positioned(
          top: 4, // رفعه للأعلى
          right: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ), // بوردر أبيض لجمالية أكثر
            ),
            constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                height: 1, // لضمان توسط الرقم تماماً
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
