import 'package:flutter/material.dart';
import 'package:nourish_me/core/theme/app_colors.dart';

class Setup extends StatelessWidget {
  const Setup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Setup',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}
