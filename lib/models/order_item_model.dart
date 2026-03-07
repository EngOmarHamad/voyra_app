/// عنصر واحد داخل الطلب (Meal Item)
class OrderItemModel {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String? image;
  final String? mealId;

  const OrderItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
    this.mealId,
  });

  /// السعر الإجمالي للعنصر
  double get totalPrice => price * quantity;

  /// ───── عرض الأسعار ─────

  String get formattedPrice => '${price.toStringAsFixed(0)} ر.س';

  String get formattedTotal => '${totalPrice.toStringAsFixed(0)} ر.س';

  /// ───── Firebase ─────

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      "price": price,
      "image": image,
      "mealId": mealId,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      quantity: map["quantity"] ?? 1,
      price: (map["price"] ?? 0).toDouble(),
      image: map["image"],
      mealId: map["mealId"],
    );
  }

  /// تعديل الكمية بسهولة
  OrderItemModel copyWith({int? quantity}) {
    return OrderItemModel(
      id: id,
      name: name,
      quantity: quantity ?? this.quantity,
      price: price,
      image: image,
      mealId: mealId,
    );
  }
}
