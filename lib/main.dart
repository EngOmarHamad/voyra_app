import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voyra_app/screens/auth/sign_in_screen.dart';
import 'core/app_theme.dart';
import 'providers/cart_provider.dart';
import 'providers/user_provider.dart';
import 'providers/workout_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/restaurants/restaurants_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/cart/basket_screen.dart';
import 'screens/cart/checkout_screen.dart';
import 'screens/order/orders_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
      ],
      child: const VoyraApp(),
    ),
  );
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
        child: const SplashScreen(),
      ),
      routes: {
        '/sign_in': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
        '/restaurants': (context) => const RestaurantsScreen(),
        '/basket': (context) => const BasketScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/orders': (context) => const OrdersScreen(),
      },
    );
  }
}
