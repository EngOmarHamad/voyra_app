import 'package:flutter/material.dart';
import 'package:voyra_app/core/app_theme.dart';
import 'package:voyra_app/screens/auth/sign_in_screen.dart';
import 'package:voyra_app/screens/restaurants/restaurants_screen.dart';
import 'home_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              image: DecorationImage(
                image: AssetImage('assets/images/background-pattern.png'),
                fit: BoxFit.fill,
                opacity: 0.3,
              ),
            ),
          ),

          Center(
            child: Image.asset(
              'assets/images/logo_light.png',
              width: MediaQuery.of(context).size.width > 800
                  ? 300
                  : MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
