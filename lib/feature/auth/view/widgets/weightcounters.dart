import '../../../../core/imports/app_routes_imports.dart';
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
  bool _isSnackBarShown = false;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _weightController =
        TextEditingController(text: authCubit.weightCounter.toString());
    _weightController.addListener(_handleWeightChange);
  }

  void _handleWeightChange() {
    String text = _weightController.text;
    if (text.isEmpty) {
      _showSnackBar("برجاء ادخال الوزن");
    } else {
      int? newValue = int.tryParse(text);
      if (newValue != null) {
        if (newValue > 50 || newValue < 160) {
          authCubit.updateWeight(newValue);
        } else {
          _showSnackBar("الوزن يجب ان يكون اكبر من او يساوي 50 kg");
        }
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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
                onLongPressEnd: (_) => authCubit.stopTimerWeight(),
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
                child: TextFormField(
                  cursorColor: AppColors.mainColor,
                  controller: _weightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.cairo24Boldmaincolor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "برجاء ادخال الوزن";
                    }
                    int? newValue = int.tryParse(value);
                    if (newValue == null || newValue < 50 || newValue > 160) {
                      return "الوزن يجب ان يكون اكبر من او يساوي 50 kg";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (Form.of(context).validate()) {
                      _showSnackBar("الوزن يجب ان يكون اكبر من او يساوي 50 kg");
                      _weightController.text =
                          authCubit.weightCounter.toString();
                    } else {
                      int newValue = int.parse(value);
                      authCubit.updateWeight(newValue);
                    }
                  },
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseWeight(),
                onLongPressEnd: (_) => authCubit.stopTimerWeight(),
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
