class MealModel {
  final String name;
  final double price;
  final String image;

  MealModel({required this.name, required this.price, required this.image});

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'image': image};
  }
}
