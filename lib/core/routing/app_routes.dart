import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourish_me/feature/auth/data/repositories/login_repo.dart';
import 'package:nourish_me/feature/auth/data/repositories/signup_repo.dart';
import 'package:nourish_me/feature/auth/logic/cubit/auth_cubit.dart';
import '../networking/dio_handler.dart';
import 'routes.dart';
import '../../feature/forgot_password/views/screens/forgot_screen.dart';
import '../../feature/auth/view/screens/login_screen.dart';
import '../../feature/forgot_password/views/screens/reset_screen.dart';
import '../../feature/auth/view/screens/signup_screen.dart';
import '../../feature/forgot_password/views/screens/succes_screen.dart';
import '../../feature/forgot_password/views/screens/verfication_screen.dart';

class AppRoutes {
  AuthCubit authCubit =
      AuthCubit(LoginRepo(DioHandler()), SignUpRepo(DioHandler()));
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => authCubit,
            child: const SignUpScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => authCubit,
            child: const LoginScreen(),
          ),
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
