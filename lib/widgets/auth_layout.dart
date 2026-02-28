import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final circleHeight = screenHeight / 1.7;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // الهيدر في الخلفية
          _buildHeader(context, circleHeight),

          // المحتوى القابل للتمرير
          SingleChildScrollView(
            padding: EdgeInsets.only(top: circleHeight - 150),
            child: Column(
              children: [
                // --- الكارد المتغير ---
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: child,
                ),

                // --- مسافة تعويضية في الأسفل ---
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double circleHeight) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: circleHeight,
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -screenWidth * 0.5,
            right: -screenWidth * 0.5,
            child: Center(
              child: ClipOval(
                child: SizedBox(
                  width: screenWidth * 2,
                  height: circleHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/auth_background.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withValues(alpha: 0.6),
                              const Color(0xFF630021).withValues(alpha: 0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/logo_light.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
