import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/feature/forgot_password/data/repositories/forget_password_repo.dart';
import 'package:nourish_me/feature/forgot_password/logic/reset/cubit/reset_cubit.dart';
import '../../feature/forgot_password/data/repositories/reser_password_repo.dart';
import '../../feature/forgot_password/logic/cubit/forgot_password_cubit.dart';
import '../../feature/forgot_password/views/screens/reset_screen.dart';
import '../../feature/forgot_password/views/screens/succes_screen.dart';

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
    }
    return null;
  }
}
