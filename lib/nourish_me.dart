import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: MaterialApp(
        initialRoute: Routes.setup,
        onGenerateRoute: AppRoutes().generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColorLight: AppColors.mainColor,
          scaffoldBackgroundColor: const Color(0xffFFFFFF),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
