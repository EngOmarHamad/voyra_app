import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer/shimmer.dart';
import 'package:voyra_app/screens/basket_screen.dart';
import 'package:voyra_app/widgets/drawer_menu_button.dart';
import '../../core/app_theme.dart';
import '../../models/restaurant.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // محاكاة تحميل بيانات
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;

    if (isLoading) {
      return _buildShimmer();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context, restaurant),

              const SizedBox(height: 16),

              _buildMealsSection(restaurant),

              const SizedBox(height: 24),

              _buildSubscriptionsSection(restaurant),

              const SizedBox(height: 24),

              _buildReviewsSection(restaurant),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context, Restaurant restaurant) {
    return Column(
      children: [
        /// 🔹 الشريط العلوي
        Container(
          color: AppColors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerMenuButton(),

              Text(
                restaurant.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BasketScreen()),
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.cartShopping,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),

        /// 🔹 نفس تصميمك القديم بالضبط
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// صورة المطعم
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(restaurant.image),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// كرت المعلومات
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.15),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// الصف الأول (التقييم + المسافة)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.rating.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'على بعد 200 كيلو',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// الصف الثاني (عدد الطلبات + وقت التحضير)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.green,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${restaurant.ordersCount} طلب",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${restaurant.preparingTime} دقيقة",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
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

  // ================= MEALS =================
  Widget _buildMealsSection(Restaurant restaurant) {
    if (restaurant.meals.isEmpty) {
      return const Text("لا توجد وجبات حالياً");
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'قائمة الوجبات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurant.meals.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (_, index) {
              final meal = restaurant.meals[index];

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        meal.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(meal.name),
                    Text("${meal.price} ₪"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ================= SUBSCRIPTIONS =================
  Widget _buildSubscriptionsSection(Restaurant restaurant) {
    if (restaurant.subscriptions.isEmpty) {
      return const Text("لا توجد اشتراكات");
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'قائمة الاشتراكات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: restaurant.subscriptions.map((sub) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: ListTile(
                  title: Text(sub.title),
                  subtitle: Text("${sub.mealsCount} وجبة - ${sub.price} ₪"),
                  trailing: Text(sub.duration),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.orange,
            size: 16,
          );
        } else if (index == fullStars && hasHalfStar) {
          return const FaIcon(
            FontAwesomeIcons.solidStarHalfStroke,
            color: Colors.orange,
            size: 16,
          );
        } else {
          return const FaIcon(
            FontAwesomeIcons.star,
            color: Colors.orange,
            size: 16,
          );
        }
      }),
    );
  }

  // ================= REVIEWS =================
  Widget _buildReviewsSection(Restaurant restaurant) {
    if (restaurant.reviewsList.isEmpty) {
      return const Text("لا توجد تقييمات");
    }

    // حساب عدد كل تقييم من 1 الى 5
    Map<int, int> ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    double total = 0;

    for (var review in restaurant.reviewsList) {
      int r = review.rating.round(); // تأكد انه int
      if (ratingCounts.containsKey(r)) {
        ratingCounts[r] = ratingCounts[r]! + 1;
        total += r;
      }
    }

    int totalReviews = restaurant.reviewsList.length;
    double average = total / totalReviews;
    final formatted = intl.NumberFormat.decimalPattern().format(totalReviews);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'متوسط تقييم المطعم',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 16),

          /// ⭐ المتوسط + البارات
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🔹 خطوط التقييم (تأخذ باقي المساحة)
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    int star = 5 - index;
                    int count = ratingCounts[star]!;
                    double percent = totalReviews == 0
                        ? 0
                        : count / totalReviews;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          SizedBox(width: 35, child: Text("$star")),

                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: percent,
                                minHeight: 4,
                                backgroundColor: Colors.grey.shade300,
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          SizedBox(
                            width: 40,
                            child: Text("${(percent * 100).toInt()}%"),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      average.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildStarRating(average),
                    const SizedBox(height: 6),

                    Text(
                      "$formatted تقييم",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 20),

          /// 🔹 التعليقات الفردية
          Column(
            children: restaurant.reviewsList.map((rev) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // السطر العلوي: صورة المستخدم + الاسم + التاريخ + التقييم
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // صورة المستخدم
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(rev.userImage),
                        ),

                        const SizedBox(width: 10),

                        // الاسم والتاريخ
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rev.userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                rev.date, // مثلاً: "2026-03-01"
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // تقييم النجوم على اليمين
                        Row(
                          children: List.generate(5, (index) {
                            if (index < rev.rating.floor()) {
                              return const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              );
                            } else if (index < rev.rating) {
                              return const Icon(
                                Icons.star_half,
                                color: Colors.orange,
                                size: 16,
                              );
                            } else {
                              return const Icon(
                                Icons.star_border,
                                color: Colors.orange,
                                size: 16,
                              );
                            }
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // التعليق
                    Text(
                      rev.comment,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ================= SHIMMER =================
  Widget _buildShimmer() {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (_, __) => Container(
            margin: const EdgeInsets.all(16),
            height: 120,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
