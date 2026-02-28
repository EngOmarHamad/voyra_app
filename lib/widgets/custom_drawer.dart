import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';
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
                      Icons.person_outline,
                      "الملف الشخصي",
                      () => {},
                    ),
                    _buildMenuItem(
                      Icons.shopping_basket_outlined,
                      "حجوزاتي",
                      () => {},
                    ),
                    _buildMenuItem(
                      Icons.account_balance_wallet_outlined,
                      "المحفظة",
                      () => {},
                    ),
                    _buildMenuItem(
                      Icons.chat_bubble_outline,
                      "قائمة المحادثات",
                      () => {},
                    ),
                    _buildMenuItem(
                      Icons.share_outlined,
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

                    _buildMenuItem(Icons.language, "اللغة", () => {}),
                    _buildMenuItem(
                      Icons.info_outline,
                      "عن التطبيق",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AboutUsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      Icons.phone_in_talk_outlined,
                      "تواصل معنا",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ContactUsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      Icons.description_outlined,
                      "الشروط والاحكام",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      Icons.privacy_tip_outlined,
                      "سياسة الخصوصية",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PrivacyScreen()),
                      ),
                    ),

                    const SizedBox(height: 20),
                    _buildMenuItem(
                      Icons.logout,
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
            icon: const Icon(Icons.close, color: AppColors.surface),
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
      leading: Icon(icon, color: AppColors.surface, size: 22),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.surface, fontSize: 15),
      ),
      onTap: onTap,
    );
  }
}
