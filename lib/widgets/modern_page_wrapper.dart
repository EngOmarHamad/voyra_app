import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';

/// Helper widget to create modern-styled pages with consistent layout
Widget buildModernPage({
  required String title,
  required List<Widget> children,
}) {
  return Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Center(child: Image.asset('assets/images/logo.png', width: 90)),
          const SizedBox(height: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
