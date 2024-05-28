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

class _CounterAgeState extends State<CounterAge> {
  late TextEditingController _ageController;
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _ageController = TextEditingController(text: authCubit.ageCounter.toString());
    _ageController.addListener(() {
      // Update the cubit when the text field changes
      int? newValue = int.tryParse(_ageController.text);
      if (newValue != null) {
        authCubit.updateAge(newValue);
      }
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Update the text field if the state changes
        if (_ageController.text != authCubit.ageCounter.toString()) {
          _ageController.text = authCubit.ageCounter.toString();
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
                onLongPressStart: (_) => authCubit.startTimerIncreaseAge(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.increamnetAge();
                  _ageController.text = authCubit.ageCounter.toString();
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
                  controller: _ageController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.cairo24Boldmaincolor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    int? newValue = int.tryParse(value);
                    if (newValue != null) {
                      authCubit.updateAge(newValue);
                    } else {
                      _ageController.text = authCubit.ageCounter.toString();
                    }
                  },
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseAge(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.decrementAge();
                  _ageController.text = authCubit.ageCounter.toString();
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
