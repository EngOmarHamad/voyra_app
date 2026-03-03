import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voyra_app/screens/auth/sign_in_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'core/app_theme.dart';
import 'screens/restaurants/restaurant_detail_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/cart/basket_screen.dart';
import 'screens/cart/checkout_screen.dart';
import 'screens/order/orders_screen.dart';

void main() {
  runApp(const VoyraApp());
}

class VoyraApp extends StatelessWidget {
  const VoyraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voyra App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', 'SA')],
      locale: const Locale('ar', 'SA'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: const SignInScreen(),
      ),
      routes: {
        '/sign_in': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
        '/restaurant_detail': (context) => const RestaurantDetailScreen(),
        '/meal_detail': (context) => const MealDetailScreen(),
        '/basket': (context) => const BasketScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/orders': (context) => const OrdersScreen(),
      },
    );
  }
}
