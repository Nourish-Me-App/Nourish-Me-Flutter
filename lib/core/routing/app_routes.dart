import 'package:flutter/material.dart';
import 'routes.dart';
import '../../feature/forgot_password/views/screens/forgot_screen.dart';
import '../../feature/auth/view/screens/login_screen.dart';
import '../../feature/forgot_password/views/screens/reset_screen.dart';
import '../../feature/auth/view/screens/signup_screen.dart';
import '../../feature/forgot_password/views/screens/succes_screen.dart';
import '../../feature/forgot_password/views/screens/verfication_screen.dart';

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
      case Routes.forgotScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgotScreen(),
        );
      case Routes.verifyEmailScreen:
        return MaterialPageRoute(
          builder: (context) => const VerifyEmailScreen(),
        );
      case Routes.resetScreen:
        return MaterialPageRoute(
          builder: (context) => const ResetScreen(),
        );
      case Routes.succesScreen:
        return MaterialPageRoute(
          builder: (context) => const SuccesScreen(),
        );
    }
    return null;
  }
}
