import 'package:nourish_me/core/networking/api_services.dart';
import 'package:nourish_me/feature/forgetpassword/data/repo/forget_password_repo.dart';
import 'package:nourish_me/feature/forgetpassword/view/screens/reset_screen.dart';
import 'package:nourish_me/feature/forgetpassword/view/screens/success_screen.dart';

import '../../feature/auth/data/repositories/signup_repo.dart';
import '../../feature/auth/view/screens/fake_screen.dart';
import '../../feature/auth/view/screens/login_screen.dart';
import '../../feature/auth/view/screens/signup_screen.dart';
import '../../feature/forgetpassword/data/repo/verify_code_repo.dart';
import '../../feature/forgetpassword/logic/forget_password_cubit.dart';
import '../../feature/forgetpassword/view/screens/forget_password_screen.dart';
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
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgetPasswordCubit(
              ForgetPasswordRepo(
                DioHandler()
              ),
              VerifyCodeRepo(
                DioHandler()
              ),
            ),
              child: const ForgetPasswordScreen()),
        );
      // case Routes.verifyEmailScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const VerifyEmailScreen(),
      //   );
      case Routes.resetScreen:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
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
