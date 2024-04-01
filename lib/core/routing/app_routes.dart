import '../../feature/auth/view/screens/fake_screen.dart';

import '../imports/app_routes_imports.dart';

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
      case Routes.fakeScreen:
        return MaterialPageRoute(
          builder: (context) => const FakeScreen(),
        );
    }
    return null;
  }
}
