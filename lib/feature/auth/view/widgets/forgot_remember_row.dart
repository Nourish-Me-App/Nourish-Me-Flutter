import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'remember_me.dart';

class ForgotAndRememberMeRow extends StatelessWidget {
  const ForgotAndRememberMeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RememberMe(),
        Text(
          'تذكرني',
          style: AppTextStyles.cairo12SemiBoldBlack,
        ),
        const Spacer(),
        TextButton(
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
            surfaceTintColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.forgotScreen,
            );
          },
          child: Text(
            'هل نسيت كلمة السر ؟',
            style: AppTextStyles.cairo12SemiBoldBlack,
          ),
        ),
      ],
    );
  }
}
