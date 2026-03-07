import '../../core/common_dependencies.dart';
import 'restaurant_info_tile.dart';

class RestaurantHeader extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantHeader({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔹 الشريط العلوي (تصميم أنيق ومنظم)
        Container(
          color: AppColors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomBackButton(),
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                const CartButton(),
              ],
            ),
          ),
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Container(
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.primary.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(restaurant.image),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// صف أيقونات المعلومات (Premium Tiles)
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RestaurantInfoTile(
                      icon: FontAwesomeIcons.solidStar,
                      value: restaurant.rating.toString(),
                      label: "التقييم",
                      color: Colors.orange,
                    ),
                    RestaurantInfoTile(
                      icon: FontAwesomeIcons.bagShopping,
                      value: "${restaurant.ordersCount}",
                      label: "طلب",
                      color: Colors.green,
                    ),
                    RestaurantInfoTile(
                      icon: FontAwesomeIcons.locationDot,
                      value: "200 كم",
                      label: "المسافة",
                      color: Colors.blue,
                    ),
                    RestaurantInfoTile(
                      icon: FontAwesomeIcons.clock,
                      value: "${restaurant.preparingTime} د",
                      label: "التحضير",
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
