class SubscriptionModel {
  final String title;
  final String duration;
  final double price;
  final int mealsCount;
  final String description;

  SubscriptionModel({
    required this.title,
    required this.duration,
    required this.price,
    required this.mealsCount,
    this.description = '',
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      title: json['title'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      mealsCount: json['mealsCount'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'price': price,
      'mealsCount': mealsCount,
      'description': description,
    };
  }
}
