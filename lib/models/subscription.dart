class Subscription {
  final String title;
  final String duration;
  final double price;
  final int mealsCount;

  Subscription({
    required this.title,
    required this.duration,
    required this.price,
    required this.mealsCount,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      title: json['title'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      mealsCount: json['mealsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'price': price,
      'mealsCount': mealsCount,
    };
  }
}
