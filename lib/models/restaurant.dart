class Restaurant {
  final String name;
  final String image;
  final double rating;
  final int reviews;
  final String dishes;

  Restaurant({
    required this.name,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.dishes,
  });

  // لتحويل JSON الى object
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      dishes: json['dishes'],
    );
  }

  // لتحويل object الى JSON (مفيد مع Firebase)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'rating': rating,
      'reviews': reviews,
      'dishes': dishes,
    };
  }
}
