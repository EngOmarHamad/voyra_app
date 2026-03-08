import 'package:voyra_app/screens/profile/profile_screen.dart';
import 'package:voyra_app/screens/static/about_us_screen.dart';
import 'package:voyra_app/screens/static/contact_us_screen.dart';
import 'package:voyra_app/screens/static/privacy_screen.dart';
import 'package:voyra_app/screens/static/terms_screen.dart';

import '../core/common_dependencies.dart';
import '../providers/user_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      backgroundColor: AppColors.primary,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drawer_pattern.png'),
            fit: BoxFit.cover,
            opacity: .2,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, userProvider),

              const Divider(color: Colors.white24, indent: 20, endIndent: 20),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    _buildMenuItem(
                      FontAwesomeIcons.user,
                      "الملف الشخصي",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfileScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.basketShopping,
                      "حجوزاتي",
                      () => {},
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.wallet,
                      "المحفظة",
                      () => {},
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.message,
                      "قائمة المحادثات",
                      () => {},
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.shareNodes,
                      "مشاركة التطبيق",
                      () => {},
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.white24,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    _buildMenuItem(FontAwesomeIcons.globe, "اللغة", () => {}),
                    _buildMenuItem(
                      FontAwesomeIcons.circleInfo,
                      "عن التطبيق",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AboutUsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.phone,
                      "تواصل معنا",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ContactUsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.fileLines,
                      "الشروط والاحكام",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      FontAwesomeIcons.shieldHalved,
                      "سياسة الخصوصية",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PrivacyScreen()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildMenuItem(
                      FontAwesomeIcons.rightFromBracket,
                      "تسجيل الخروج",
                      () => {},
                      isLogout: true,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserProvider provider) {
    final user = provider.currentUser;
    final isLoading = provider.isLoading; // نستخدم حالة التحميل من البروفايدر

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: isLoading
                ? _buildShimmerHeader() // إذا كان يحمل، اعرض الوميض
                : _buildActualHeader(user), // إذا انتهى، اعرض البيانات
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: AppColors.surface,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // ودجت الوميض (Shimmer)
  Widget _buildShimmerHeader() {
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.white10,
      child: Row(
        children: [
          const CircleAvatar(radius: 28, backgroundColor: Colors.white),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 100, height: 12, color: Colors.white),
              const SizedBox(height: 8),
              Container(width: 140, height: 10, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  // ودجت البيانات الحقيقية
  Widget _buildActualHeader(dynamic user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white24,
          backgroundImage: const AssetImage("assets/images/user.jpg"),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? "مستخدم فويرة",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.surface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                user?.email ?? "جارٍ التحميل...",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ودجت بناء عناصر القائمة
  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {

    bool isLogout = false,
  }) {
    return ListTile(
      visualDensity: const VisualDensity(
        vertical: -2,
      ), // لتقليل المسافات بين العناصر
      leading: FaIcon(icon, color: AppColors.surface, size: 18),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.surface, fontSize: 15),
      ),
      onTap: onTap,
    );
  }
}
