import '../../core/common_dependencies.dart';

class RestaurantStarRating extends StatelessWidget {
  final double rating;
  final double size;

  const RestaurantStarRating({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.orange,
            size: size,
          );
        } else if (index == fullStars && hasHalfStar) {
          return FaIcon(
            FontAwesomeIcons.solidStarHalfStroke,
            color: Colors.orange,
            size: size,
          );
        } else {
          return FaIcon(
            FontAwesomeIcons.star,
            color: Colors.orange,
            size: size,
          );
        }
      }),
    );
  }
}
