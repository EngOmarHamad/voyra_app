import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.surface,
          type: BottomNavigationBarType.shifting,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(0),
              label: 'الرئيسية',
              backgroundColor: Colors.black,
            ),

            BottomNavigationBarItem(
              icon: _buildIcon(1),
              label: 'التمارين',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(2),
              label: 'حاسبة السعرات',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(3),
              label: 'قائمة المطاعم',
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    final isSelected = currentIndex == index;
    final icons = [
      Icons.home_outlined,
      Icons.calculate_outlined,
      Icons.calendar_today_outlined,
      Icons.restaurant_menu_outlined,
    ];
    return CircleAvatar(
      radius: 18,
      backgroundColor: isSelected
          ? AppColors.primary
          : AppColors.primary.withAlpha(0), // لون خفيف إذا غير محدد
      child: Icon(
        icons[index],
        color: isSelected ? AppColors.surface : Colors.grey,
      ),
    );
  }
}
