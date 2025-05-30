import 'package:flutter/material.dart';
import 'package:post_app/Screens/sign_in/signin.dart';
import 'package:post_app/Screens/splashscreen.dart';

import '../Screens/homescreen/home.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        // Handle halaman lain jika diperlukan.
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  static void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
  }
}
