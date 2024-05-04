import '../../feature/auth/data/repositories/continue_register_repo.dart';
import '../../feature/auth/logic/cubit/auth_cubit.dart';
import '../../feature/auth/view/screens/data_screen.dart';
import '../../feature/home/view/screens/home_screen.dart';
import '../../feature/home/view/widgets/bottom_nav_bar.dart';
import '../../feature/onboarding/logic/on_boarding_cubit.dart';
import '../../feature/onboarding/view/screens/onboarding.dart';
import '../../feature/questions/data/repositories/questions_answers_repo.dart';
import '../../feature/questions/logic/cubit/questions_cubit.dart';
import '../../feature/questions/logic/cubit/questions_ui_cubit.dart';
import '../../feature/questions/view/screens/questions.dart';
import '../imports/app_routes_imports.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    DioHandler dioHandler = DioHandler();
    switch (routeSettings.name) {
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              LoginRepo(dioHandler),
              SignUpRepo(dioHandler),
              ContinueRegisterRepo(dioHandler),
            ),
            child: const SignUpScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              LoginRepo(dioHandler),
              SignUpRepo(dioHandler),
              ContinueRegisterRepo(dioHandler),
            ),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgetPasswordCubit(
              ForgetPasswordRepo(dioHandler),
              CheckCodeRepo(dioHandler),
              ResetPasswordRepo(dioHandler),
            ),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.verifyEmailScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgetPasswordCubit>(
            create: (context) => ForgetPasswordCubit(
              ForgetPasswordRepo(dioHandler),
              CheckCodeRepo(dioHandler),
              ResetPasswordRepo(dioHandler),
            ),
            child: const VerifyEmailScreen(),
          ),
        );
      case Routes.resetScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForgetPasswordCubit>(
            create: (context) => ForgetPasswordCubit(
              ForgetPasswordRepo(dioHandler),
              CheckCodeRepo(dioHandler),
              ResetPasswordRepo(dioHandler),
            ),
            child: const ResetPasswordScreen(),
          ),
        );
      case Routes.succesScreen:
        return MaterialPageRoute(
          builder: (context) => const SuccesScreen(),
        );
      case Routes.questions:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<QuestionsUICubit>(
                create: (context) => QuestionsUICubit(),
              ),
              BlocProvider<QuestionsCubit>(
                create: (context) => QuestionsCubit(
                  QuestionsAndAnswersRepo(dioHandler),
                ),
              ),
            ],
            child: const Questions(),
          ),
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
              LoginRepo(dioHandler),
              SignUpRepo(dioHandler),
              ContinueRegisterRepo(dioHandler),
            ),
            child: const ContinueRegisterScreen(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.bottomNavBar:
        return MaterialPageRoute(
          builder: (context) => const BottomNav(),
        );
    }
    return null;
  }
}
