import 'package:nourish_me/core/imports/app_routes_imports.dart';

import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class WeightCounter extends StatefulWidget {
  const WeightCounter({super.key});

  @override
  State<WeightCounter> createState() => _WeightCounterState();
}

class _WeightCounterState extends State<WeightCounter> {
  late TextEditingController _weightController;
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _weightController = TextEditingController(text: authCubit.weightCounter.toString());
    _weightController.addListener(() {
      int? newValue = int.tryParse(_weightController.text);
      if (newValue != null && newValue >= 0) {
        authCubit.updateWeight(newValue);
      }
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (_weightController.text != authCubit.weightCounter.toString()) {
          _weightController.text = authCubit.weightCounter.toString();
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
                onLongPressStart: (_) => authCubit.startTimerIncreaseWeight(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.incrementWeight();
                  _weightController.text = authCubit.weightCounter.toString();
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
                  controller: _weightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.cairo24Boldmaincolor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    int? newValue = int.tryParse(value);
                    if (newValue != null && newValue >= 0) {
                      authCubit.updateWeight(newValue);
                    } else {
                      _weightController.text = authCubit.weightCounter.toString();
                    }
                  },
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseWeight(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.decrementWeight();
                  _weightController.text = authCubit.weightCounter.toString();
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
