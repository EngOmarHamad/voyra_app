class Subscription {
  final String title;
  final String duration;
  final double price;
  final int mealsCount;
  final String description;

  Subscription({
    required this.title,
    required this.duration,
    required this.price,
    required this.mealsCount,
    this.description = '',
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
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
