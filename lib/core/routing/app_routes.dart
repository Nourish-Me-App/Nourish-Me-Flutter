import '../../feature/auth/data/repositories/signup_repo.dart';
import '../../feature/auth/view/screens/fake_screen.dart';
import '../../feature/auth/view/screens/login_screen.dart';
import '../../feature/auth/view/screens/signup_screen.dart';
import '../../feature/forgot_password/logic/cubit/forgot_password_cubit.dart';
import '../../feature/forgot_password/logic/reset/cubit/reset_cubit.dart';
import '../../feature/forgot_password/data/repositories/forget_password_repo.dart';
import '../../feature/forgot_password/data/repositories/reser_password_repo.dart';
import '../imports/app_routes_imports.dart';
import '../imports/signup_screen_imports.dart';


class AppRoutes {
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
            child:  const LoginScreen(),
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
