import '../../core/common_dependencies.dart';
import 'restaurant_detail_screen.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  String sortBy = 'الترتيب';
  String restaurantType = 'نوع المطعم';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Search and Filter Row
            Column(
              children: [
                CustomTextField(
                  hint: 'بحث',
                  prefixIcon: const Center(
                    widthFactor: 1.0,
                    child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 14),
                  ),
                  height: 40,
                  fontSize: 14,
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField(
                        value: restaurantType,
                        items: ['نوع المطعم', 'شعبي', 'إيطالي', 'شرقي'],
                        onChanged: (value) {
                          setState(() => restaurantType = value!);
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: CustomDropdownField(
                        value: sortBy,
                        items: ['الترتيب', 'الأعلى تقييم', 'الأقرب'],
                        onChanged: (value) {
                          setState(() => sortBy = value!);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Restaurants Grid
            LayoutBuilder(
              builder: (context, constraints) {
                double currentMaxExtent = 200;
                double cardWidth =
                    (constraints.maxWidth /
                    (constraints.maxWidth / currentMaxExtent).ceil());
                double dynamicRatio = cardWidth < 160 ? 0.65 : 0.78;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: dynamicRatio,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return RestaurantCard(index: index);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final int index;
  const RestaurantCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final restaurants = [
      Restaurant(
        name: 'مطعم الدجاج',
        image: 'assets/images/auth_background.png',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج المشوية - 100 طبق',
        ordersCount: 540,
        preparingTime: 25,

        meals: [
          Meal(
            name: 'برياني دجاج',
            price: 20,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'شاورما',
            price: 15,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'برياني دجاج',
            price: 20,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'شاورما',
            price: 15,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'شاورما',
            price: 15,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'شاورما',
            price: 15,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'شاورما',
            price: 15,
            image: 'assets/images/auth_background.png',
          ),
        ],

        subscriptions: [
          Subscription(
            title: 'وجبات عادية',
            duration: '3 أشهر',
            price: 200,
            mealsCount: 8,
            description:
                'يقدم هذا النوع من الاشتراك 8 وجبات مميزة مليئة بالبروتين منهم 4 مع نشويات و 4 مع كربوهيدرات',
          ),
          Subscription(
            title: 'وجبات برو',
            duration: '6 أشهر',
            price: 350,
            mealsCount: 16,
            description:
                'باقة مخصصة للرياضيين المحترفين تحتوي على 16 وجبة غنية بالألياف والمعادن الضرورية لبناء العضلات',
          ),
          Subscription(
            title: 'وجبات عادية',
            duration: '3 أشهر',
            price: 200,
            mealsCount: 8,
            description:
                'يقدم هذا النوع من الاشتراك 8 وجبات مميزة مليئة بالبروتين منهم 4 مع نشويات و 4 مع كربوهيدرات',
          ),
          Subscription(
            title: 'وجبات برو',
            duration: '6 أشهر',
            price: 350,
            mealsCount: 16,
            description:
                'باقة مخصصة للرياضيين المحترفين تحتوي على 16 وجبة غنية بالألياف والمعادن الضرورية لبناء العضلات',
          ),
        ],

        reviewsList: [
          Review(
            userName: 'محمد احمد',
            rating: 4.8,
            comment: 'رائع جدا والطعم ممتاز',
            userImage: 'assets/images/user.jpg',
            date: '2026-03-01',
          ),
          Review(
            userName: 'سارة خالد',
            rating: 5.0,
            comment: 'أفضل مطعم جربته',
            userImage: 'assets/images/user.jpg',
            date: '2026-03-01',
          ),
          Review(
            userName: 'محمد احمد',
            rating: 4.8,
            comment: 'رائع جدا والطعم ممتاز',
            userImage: 'assets/images/user.jpg',
            date: '2026-03-01',
          ),
          Review(
            userName: 'سارة خالد',
            rating: 5.0,
            comment: 'أفضل مطعم جربته',
            userImage: 'assets/images/user.jpg',
            date: '2026-03-01',
          ),
        ],
      ),

      Restaurant(
        name: 'مطعم كنتاكي',
        image: 'assets/images/auth_background.png',
        rating: 4.7,
        reviews: 80,
        dishes: 'عجائب الدجاج - 100 طبق',
        ordersCount: 430,
        preparingTime: 20,

        meals: [
          Meal(
            name: 'زنجر',
            price: 18,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'كرسبي',
            price: 22,
            image: 'assets/images/auth_background.png',
          ),
        ],

        subscriptions: [
          Subscription(
            title: 'باقة أسبوعية',
            duration: '1 شهر',
            price: 120,
            mealsCount: 5,
          ),
        ],

        reviewsList: [
          Review(
            userName: 'أحمد علي',
            rating: 4.5,
            comment: 'طعم لذيذ لكن التوصيل بطيء قليلاً',
            userImage: 'assets/images/user.jpg',
            date: '2026-03-01',
          ),
        ],
      ),

      Restaurant(
        name: 'مطعم الشيف',
        image: 'assets/images/auth_background.png',
        rating: 4.6,
        reviews: 60,
        dishes: 'الطعام المتنوع - 100 طبق',
        ordersCount: 300,
        preparingTime: 30,

        meals: [
          Meal(
            name: 'ستيك',
            price: 40,
            image: 'assets/images/auth_background.png',
          ),
          Meal(
            name: 'باستا',
            price: 25,
            image: 'assets/images/auth_background.png',
          ),
        ],

        subscriptions: [],
        reviewsList: [],
      ),

      Restaurant(
        name: 'مطعم الدجاج',
        image: 'assets/images/auth_background.png',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج - 100 طبق',
        ordersCount: 500,
        preparingTime: 22,
        meals: [],
        subscriptions: [],
        reviewsList: [],
      ),

      Restaurant(
        name: 'مطعم كنتاكي',
        image: 'assets/images/auth_background.png',
        rating: 4.8,
        reviews: 95,
        dishes: 'عجائب الدجاج - 100 طبق',
        ordersCount: 470,
        preparingTime: 18,
        meals: [],
        subscriptions: [],
        reviewsList: [],
      ),

      Restaurant(
        name: 'مطعم الدجاج',
        image: 'assets/images/auth_background.png',
        rating: 4.9,
        reviews: 100,
        dishes: 'عجائب الدجاج - 100 طبق',
        ordersCount: 600,
        preparingTime: 26,
        meals: [],
        subscriptions: [],
        reviewsList: [],
      ),
    ];
    final restaurant = restaurants[index];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDetailScreen(restaurant: restaurant),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 14, right: 4, left: 4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(restaurant.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
            ),

            // قسم المعلومات - يأخذ 60% من مساحة الكرت
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // يوزع العناصر عمودياً بالتساوي
                  children: [
                    // اسم المطعم
                    Text(
                      restaurant.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),

                    // التقييم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.orange,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.rating}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          // لضمان عدم حدوث Overflow في حال زاد عدد المراجعات
                          child: Text(
                            '(${restaurant.reviews})',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // وصف الأطباق
                    Text(
                      restaurant.dishes,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),

                    // زر التفاصيل
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RestaurantDetailScreen(restaurant: restaurant),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: const BorderSide(
                            color: Color(0xFFE52D50),
                          ), // لون AppColors.primary
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'التفاصيل',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFFE52D50),
                            fontFamily: GoogleFonts.cairo().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
