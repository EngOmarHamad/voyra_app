import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voyra_app/core/app_theme.dart';

class DrawerMenuButton extends StatelessWidget {
  const DrawerMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const FaIcon(
          FontAwesomeIcons.barsStaggered,
          color: AppColors.primary,
          size: 22,
        ),
      ),
    );
  }
}
