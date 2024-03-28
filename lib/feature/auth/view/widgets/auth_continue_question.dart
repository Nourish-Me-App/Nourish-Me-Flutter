import 'package:flutter/material.dart';
import '../../../../core/routing/routes.dart';
import 'package:nourish_me/core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';

class AuthContinueQuestion extends StatelessWidget {
  final String label, action, route;
  const AuthContinueQuestion(
      {super.key,
      required this.label,
      required this.action,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.cairo12SemiBoldBlack,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () => route == Routes.loginScreen
                ? Navigator.pushNamed(
                    context,
                    route,
                  )
                : Navigator.pushNamedAndRemoveUntil(
                    context, route, (route) => false),
            child: Text(
              action,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.cairo12BoldMainColor.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
