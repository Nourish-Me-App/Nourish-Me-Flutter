import 'dart:async';

import 'package:flutter/services.dart';
import '../../logic/cubit/data_screen_cubit.dart';

import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class WeightCounter extends StatefulWidget {
  const WeightCounter({super.key});

  @override
  State<WeightCounter> createState() => _WeightCounterState();
}

class _WeightCounterState extends State<WeightCounter> {
  late TextEditingController _weightController;
  late DataScreenCubit dataScreenCubit;
  bool _isSnackBarShown = false;
  Timer? _timerWeight;

  @override
  void initState() {
    super.initState();
    dataScreenCubit = BlocProvider.of<DataScreenCubit>(context);
    _weightController =
        TextEditingController(text: dataScreenCubit.weightCounter.toString());
    _weightController.addListener(_handleWeightChange);
  }

  void startTimerIncreaseWeight() {
    _timerWeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (dataScreenCubit.weightCounter < 160) {
        dataScreenCubit.incrementWeight();
      } else {
        stopTimerWeight();
      }
      _weightController.text = dataScreenCubit.weightCounter.toString();
    });
  }

  void startTimerDecreaseWeight() {
    _timerWeight = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (dataScreenCubit.weightCounter > 40) {
        dataScreenCubit.decrementWeight();
      } else {
        stopTimerWeight();
      }
      _weightController.text = dataScreenCubit.weightCounter.toString();
    });
  }

  void stopTimerWeight() {
    _timerWeight?.cancel();
  }

  void _handleWeightChange() {
    String text = _weightController.text;
    int? newValue = int.tryParse(text);
    if (newValue != null) {
      if (newValue >= 40 || newValue <= 160) {
        dataScreenCubit.updateWeight(newValue);
      } else {
        _showSnackBar('kg الوزن يجب أن يكون بين 40 و 160');
      }
    }
  }

  void _showSnackBar(String message) {
    if (!_isSnackBarShown) {
      _isSnackBarShown = true;
      HelperMethods.showCustomSnackBarError(context, message);
      Future.delayed(const Duration(seconds: 3), () {
        _isSnackBarShown = false;
      });
    }
  }

  @override
  void dispose() {
    _weightController.removeListener(_handleWeightChange);
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            onLongPressStart: (_) => startTimerIncreaseWeight(),
            onLongPressEnd: (_) => stopTimerWeight(),
            onTap: () {
              dataScreenCubit.incrementWeight();
              _weightController.text = dataScreenCubit.weightCounter.toString();
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
            child: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(3)],
              cursorColor: AppColors.mainColor,
              controller: _weightController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: AppTextStyles.cairo24Boldmaincolor,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                if (Form.of(context).validate()) {
                  int.tryParse(value) == null
                      ? null
                      : int.parse(value) < 40 || int.parse(value) > 160
                          ? _showSnackBar('kg الوزن يجب أن يكون بين 40 و 160')
                          : null;
                  _weightController.text =
                      dataScreenCubit.weightCounter.toString();
                } else {
                  int newValue = int.parse(value);
                  dataScreenCubit.updateWeight(newValue);
                }
              },
            ),
          ),
          GestureDetector(
            onLongPressStart: (_) => startTimerDecreaseWeight(),
            onLongPressEnd: (_) => stopTimerWeight(),
            onTap: () {
              dataScreenCubit.decrementWeight();
              _weightController.text = dataScreenCubit.weightCounter.toString();
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
  }
}
