import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helpers/app_constants.dart';
import 'core/helpers/cache_helper.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/routes.dart';
import 'core/theme/app_colors.dart';

class NourishMe extends StatelessWidget {
  const NourishMe({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //* The size of the screen of figma design.
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        initialRoute: Routes.bottomNavBar,
        // CacheHelper().getData(key: AppConstants.rememberMeToken) == null
        //     ? Routes.splash
        //     : CacheHelper().getData(
        //                 key: AppConstants.isFirstQuestionsComplete) ==
        //             'no'
        //         ? Routes.questions
        //         : Routes.bottomNavBar,
        onGenerateRoute: AppRoutes().generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(
              color: AppColors.mainColor,
              size: 28.r,
            ),
          ),
          primaryColorLight: AppColors.mainColor,
          scaffoldBackgroundColor: const Color(0xffFFFFFF),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
