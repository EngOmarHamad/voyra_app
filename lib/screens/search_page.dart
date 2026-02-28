import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "ابحث عن تمارين، وجبات...",
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(child: Text("ابدأ البحث الآن")),
    );
  }
}
