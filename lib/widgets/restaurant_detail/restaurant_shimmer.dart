import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantShimmer extends StatelessWidget {
  const RestaurantShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (_, _) => Container(
            margin: const EdgeInsets.all(16),
            height: 120,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
