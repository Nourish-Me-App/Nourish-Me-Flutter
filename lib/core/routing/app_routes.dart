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
            create: (context) =>
                AuthCubit(LoginRepo(DioHandler()), SignUpRepo(DioHandler())),
            child: const SignUpScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) =>
                AuthCubit(LoginRepo(DioHandler()), SignUpRepo(DioHandler())),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgotScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgotPasswordCubit>(
            create: (context) =>
                ForgotPasswordCubit(ForegetPasswordRepoSitories()),
            child: const ForgotScreen(),
          ),
        );

      case Routes.resetScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider<ForgotPasswordCubit>(
              create: (context) =>
                  ForgotPasswordCubit(ForegetPasswordRepoSitories()),
            ),
            BlocProvider<ResetCubit>(
                create: (context) => ResetCubit(ResetPasswordRepositories())),
          ], child: const ResetScreen()),
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
