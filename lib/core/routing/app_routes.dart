import 'package:nourish_me/feature/auth/view/screens/data_screen.dart';
import 'package:nourish_me/feature/onboarding/view/screens/onboarding.dart';

import '../../feature/auth/data/repositories/continue_register_repo.dart';
import '../../feature/onboarding/logic/on_boarding_cubit.dart';
import '../imports/app_routes_imports.dart';
import '../imports/signup_screen_imports.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(LoginRepo(DioHandler()),
                SignUpRepo(DioHandler()), ContinueRegisterRepo(DioHandler())),
            child: const SignUpScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(LoginRepo(DioHandler()),
                SignUpRepo(DioHandler()), ContinueRegisterRepo(DioHandler())),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => ForgetPasswordCubit(
                    ForgetPasswordRepo(DioHandler()),
                    CheckCodeRepo(DioHandler()),
                    ResetPasswordRepo(DioHandler()),
                  ),
              child: const ForgetPasswordScreen()),
        );
      case Routes.verifyEmailScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgetPasswordCubit>(
              create: (context) => ForgetPasswordCubit(
                    ForgetPasswordRepo(DioHandler()),
                    CheckCodeRepo(DioHandler()),
                    ResetPasswordRepo(DioHandler()),
                  ),
              child: const VerifyEmailScreen()),
        );
      case Routes.resetScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgetPasswordCubit>(
              create: (context) => ForgetPasswordCubit(
                    ForgetPasswordRepo(DioHandler()),
                    CheckCodeRepo(DioHandler()),
                    ResetPasswordRepo(DioHandler()),
                  ),
              child: const ResetPasswordScreen()),
        );
      case Routes.succesScreen:
        return MaterialPageRoute(
          builder: (context) => const SuccesScreen(),
        );
      case Routes.fakeScreen:
        return MaterialPageRoute(
          builder: (context) => const FakeScreen(),
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<OnBoardingCubit>(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingScreen(),
          ),
        );
      case Routes.continueRegisterScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              LoginRepo(DioHandler()),
              SignUpRepo(DioHandler()),
              ContinueRegisterRepo(DioHandler()),
            ),
            child: const ContinueRegisterScreen(),
          ),
        );
    }
    return null;
  }
}
