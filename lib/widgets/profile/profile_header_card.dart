import '../../core/common_dependencies.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String imageUrl;
  final bool isEdit;
  final VoidCallback? onCameraTap;
  const ProfileHeaderCard({
    super.key,
    required this.imageUrl,
    this.isEdit = false,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    // نستخدم LayoutBuilder للحصول على عرض الوالد بدقة بدلاً من MediaQuery
    return LayoutBuilder(
      builder: (context, constraints) {
        double avatarRadius = 50;

        return Center(
          child: SizedBox(
            // نحدد ارتفاع ثابت يشمل الكارت + البروز الخاص بالصورة
            height: 150 + (avatarRadius / 2),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                // 1. الخلفية المزخرفة (Card)
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),

                // 2. الصورة الشخصية (Avatar)
                Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ),
                      // أيقونة الكاميرا تظهر فقط في وضع التعديل
                      if (isEdit)
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: GestureDetector(
                            onTap: onCameraTap,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                FontAwesomeIcons.camera,
                                size: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
