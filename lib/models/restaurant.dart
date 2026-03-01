import 'package:voyra_app/models/meal.dart';
import 'package:voyra_app/models/review.dart';
import 'package:voyra_app/models/subscription.dart';

class Restaurant {
  final String name;
  final String image;
  final double rating;
  final int reviews;
  final String dishes;

  final int ordersCount;        // عدد الطلبات السابقة
  final int preparingTime;      // وقت التحضير بالدقائق

  final List<Meal> meals;              // قائمة الوجبات
  final List<Subscription> subscriptions;  // الاشتراكات
  final List<Review> reviewsList;      // التقييمات

  Restaurant({
    required this.name,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.dishes,
    required this.ordersCount,
    required this.preparingTime,
    required this.meals,
    required this.subscriptions,
    required this.reviewsList,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      dishes: json['dishes'],
      ordersCount: json['ordersCount'],
      preparingTime: json['preparingTime'],

      meals: (json['meals'] as List)
          .map((e) => Meal.fromJson(e))
          .toList(),

      subscriptions: (json['subscriptions'] as List)
          .map((e) => Subscription.fromJson(e))
          .toList(),

      reviewsList: (json['reviewsList'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'rating': rating,
      'reviews': reviews,
      'dishes': dishes,
      'ordersCount': ordersCount,
      'preparingTime': preparingTime,
      'meals': meals.map((e) => e.toJson()).toList(),
      'subscriptions': subscriptions.map((e) => e.toJson()).toList(),
      'reviewsList': reviewsList.map((e) => e.toJson()).toList(),
    };
  }
}