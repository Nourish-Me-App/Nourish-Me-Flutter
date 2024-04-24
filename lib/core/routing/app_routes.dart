import 'package:nourish_me/feature/questions/logic/cubit/questions_cubit.dart';
import 'package:nourish_me/feature/questions/logic/cubit/questions_ui_cubit.dart';
import 'package:nourish_me/feature/questions/view/screens/fake_home.dart';

import '../../feature/questions/data/repositories/questions_answers_repo.dart';
import '../../feature/questions/view/screens/questions.dart';
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
      case Routes.fakeHome:
        return MaterialPageRoute(
          builder: (context) => const FakeHome(),
        );
      case Routes.questions:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<QuestionsUICubit>(
                create: (context) => QuestionsUICubit(),
              ),
              BlocProvider<QuestionsCubit>(
                create: (context) =>
                    QuestionsCubit(QuestionsAndAnswersRepo(DioHandler())),
              ),
            ],
            child: const Questions(),
          ),
        );
    }
    return null;
  }
}
