import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voyra_app/core/app_theme.dart';
import 'package:voyra_app/screens/profile/profile_screen.dart';
import 'package:voyra_app/screens/static/about_us_screen.dart';
import 'package:voyra_app/screens/static/contact_us_screen.dart';
import 'package:voyra_app/screens/static/privacy_screen.dart';
import 'package:voyra_app/screens/static/terms_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              _buildHeader(context),

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

  // ودجت الهيدر
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/user.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "أحمد علي",
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "examb88@gmail.com",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: AppColors.surface,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context), // لإغلاق الـ Drawer
          ),
        ],
      ),
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
