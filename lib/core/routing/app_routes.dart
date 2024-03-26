import 'package:flutter/material.dart';
import 'package:nourish_me/core/routing/routes.dart';
import 'package:nourish_me/feature/auth/view/screens/login_screen.dart';
import 'package:nourish_me/feature/auth/view/screens/signup_screen.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
    }
    return null;
  }
}
