
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/cubit/auth_cubit.dart';

import 'package:nourish_me/core/imports/app_routes_imports.dart';
import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class HeightCounter extends StatefulWidget {
  const HeightCounter({super.key});

  @override
  State<HeightCounter> createState() => _HeightCounterState();
}

class _HeightCounterState extends State<HeightCounter> {
  late TextEditingController _heightController;
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _heightController = TextEditingController(text: authCubit.heightCounter.toString());
    _heightController.addListener(() {
      int? newValue = int.tryParse(_heightController.text);
      if (newValue != null && newValue >= 0) {
        authCubit.updateHeight(newValue);
      }
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (_heightController.text != authCubit.heightCounter.toString()) {
          _heightController.text = authCubit.heightCounter.toString();
        }

        return Container(
          width: double.infinity,
          height: 64.h,
          decoration: BoxDecoration(
            color: AppColors.counterColor,
            border: Border.all(color: AppColors.counterColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerIncreaseHeight(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.incrementHeight();
                  _heightController.text = authCubit.heightCounter.toString();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: TextField(
                  controller: _heightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.cairo24Boldmaincolor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    int? newValue = int.tryParse(value);
                    if (newValue != null && newValue >= 0) {
                      authCubit.updateHeight(newValue);
                    } else {
                      _heightController.text = authCubit.heightCounter.toString();
                    }
                  },
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseHeight(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.decrementHeight();
                  _heightController.text = authCubit.heightCounter.toString();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
