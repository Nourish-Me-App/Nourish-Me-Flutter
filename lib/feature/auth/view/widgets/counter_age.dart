
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../logic/cubit/auth_cubit.dart';

class CounterAge extends StatefulWidget {
  const CounterAge({super.key});

  @override
  State<CounterAge> createState() => _CounterAgeState();
}

late AuthCubit authCubit;

class _CounterAgeState extends State<CounterAge> {
  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
            width: double.infinity,
            height: 64.h,
            decoration: BoxDecoration(
                color: AppColors.counterColor,
                border: Border.all(color: AppColors.counterColor),
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onLongPressStart: (_) => authCubit.startTimerIncreaseAge(),
                  onLongPressEnd: (_) => authCubit.stopTimer(),
                  onTap: () {
                    authCubit.increamnetAge();
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
                Text(
                  '${authCubit.ageCounter}',
                  style: AppTextStyles.cairo24Boldmaincolor,
                ),
                GestureDetector(
                  onLongPressStart: (_) => authCubit.startTimerDecreaseAge(),
                  onLongPressEnd: (_) => authCubit.stopTimer(),
                  onTap: () => authCubit.decrementAge(),
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
            ));
      },
    );
  }
}
