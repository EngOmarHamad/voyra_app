import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
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
      FontAwesomeIcons.house,
      FontAwesomeIcons.dumbbell,
      FontAwesomeIcons.calculator,
      FontAwesomeIcons.utensils,
    ];
    return CircleAvatar(
      radius: 18,
      backgroundColor: isSelected
          ? AppColors.primary
          : AppColors.primary.withAlpha(0), // لون خفيف إذا غير محدد
      child: FaIcon(
        icons[index],
        color: isSelected ? AppColors.surface : Colors.grey,
        size: 16,
      ),
    );
  }
}
