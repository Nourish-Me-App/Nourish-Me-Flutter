import 'package:nourish_me/feature/workout/data/repo/workout_repo.dart';
import 'package:nourish_me/feature/workout/logic/cubit/workout_cubit.dart';

import '../imports/app_routes_imports.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 750);
}

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    DioHandler dioHandler = DioHandler();
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.signUpScreen:
        return CustomPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              LoginRepo(dioHandler),
              SignUpRepo(dioHandler),
            ),
            child: const SignUpScreen(),
          ),
        );
      case Routes.loginScreen:
        return CustomPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              LoginRepo(dioHandler),
              SignUpRepo(dioHandler),
            ),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPasswordScreen:
        return CustomPageRoute(
          builder: (context) => BlocProvider<ForgetPasswordCubit>(
            create: (context) => ForgetPasswordCubit(
              ForgetPasswordRepo(dioHandler),
              CheckCodeRepo(dioHandler),
              ResetPasswordRepo(dioHandler),
            ),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.verifyEmailScreen:
        return CustomPageRoute(
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
        return CustomPageRoute(
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
            child: Questions(loginType: args == null ? null : args as String),
          ),
        );
      case Routes.onBoarding:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlocProvider<OnBoardingCubit>(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.3;
            const end = 1.0;
            const curve = Curves.easeInCubic;

            Animatable<double> tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.continueRegisterScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DataScreenCubit>(
            create: (context) => DataScreenCubit(
              ContinueRegisterRepo(dioHandler),
            ),
            child: ContinueRegisterScreen(loginType: args == null ? null : args as String),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.newPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(
              LogoutRepo(DioHandler()),
              UpdateProfileRepo(DioHandler()),
            ),
            child: const NewPassword(),
          ),
        );
      case Routes.bottomNavBar:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(
                  HomeRepo(DioHandler()),
                )..fetchHomeData(AppConstants.home),
              ),
              BlocProvider<DietsCubit>(
                create: (context) => DietsCubit(
                  DietsRepo(DioHandler()),
                )..fetchDietMeals(AppConstants.diet),
              ),
              BlocProvider<WorkoutCubit>(
                create: (context) => WorkoutCubit(
                  WorkoutRepo(DioHandler()),
                )..fetchWorkout(AppConstants.workOut),
              ),
              BlocProvider<SettingsCubit>(
                create: (context) => SettingsCubit(
                  LogoutRepo(DioHandler()),
                  UpdateProfileRepo(DioHandler()),
                ),
              ),
              BlocProvider<BotNavBarCubit>(
                create: (context) => BotNavBarCubit(),
              ),
            ],
            child: const BottomNav(),
          ),
        );
    }
    return null;
  }
}
