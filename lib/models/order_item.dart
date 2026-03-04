/// وجبة واحدة (meal line) داخل الطلب
class OrderItem {
  final String name;
  final int quantity;
  final double price;

  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => price * quantity;

  /// عرض السعر للواجهة
  String get formattedPrice => '${price.toStringAsFixed(0)} ر.س';

  String get formattedTotal => '${totalPrice.toStringAsFixed(0)} ر.س';
}
