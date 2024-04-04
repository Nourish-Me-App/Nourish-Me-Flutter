import '../../feature/auth/view/screens/fake_screen.dart';

import '../imports/app_routes_imports.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourish_me/core/api/dio_consumer.dart';
import '../../feature/auth/forgot_password/data/repositories/forget_password_repositories.dart';
import '../../feature/auth/forgot_password/logic/cubit/forgot_password_cubit.dart';
import 'routes.dart';
import '../../feature/auth/forgot_password/views/screens/forgot_screen.dart';
import '../../feature/auth/view/screens/login_screen.dart';
import '../../feature/auth/forgot_password/views/screens/reset_screen.dart';
import '../../feature/auth/view/screens/signup_screen.dart';
import '../../feature/auth/forgot_password/views/screens/succes_screen.dart';
import '../../feature/auth/forgot_password/views/screens/verfication_screen.dart';

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
          builder: (context) => BlocProvider<ForgotPasswordCubit>(
            create: (context) => ForgotPasswordCubit(ForgetPasswordRepositories(
                apiConsumer: DioConsumer(dio: Dio()))),
            child: const ForgotScreen(),
          ),
        );
      case Routes.verifyEmailScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgotPasswordCubit>(
            create: (context) => ForgotPasswordCubit(ForgetPasswordRepositories(
                apiConsumer: DioConsumer(dio: Dio()))),
            child: const VerifyEmailScreen(),
          ),
        );
      case Routes.resetScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgotPasswordCubit>(
            create: (context) => ForgotPasswordCubit(ForgetPasswordRepositories(
                apiConsumer: DioConsumer(dio: Dio()))),
            child: ResetScreen(),
          ),
        );
      case Routes.succesScreen:
        return MaterialPageRoute(
          builder: (context) => const SuccesScreen(),
        );
      case Routes.fakeScreen:
        return MaterialPageRoute(
          builder: (context) => const FakeScreen(),
        );
    }
    return null;
  }
}
