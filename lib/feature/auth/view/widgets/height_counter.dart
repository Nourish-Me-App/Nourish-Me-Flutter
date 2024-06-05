import '../../../../core/imports/app_routes_imports.dart';
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
  bool _isSnackBarShown = false;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _heightController =
        TextEditingController(text: authCubit.heightCounter.toString());
    _heightController.addListener(_handleheightChange);
  }

  void _handleheightChange() {
    String text = _heightController.text;
    if (text.isEmpty) {
      _showSnackBar("برجاء ادخال الطول");
    } else {
      int? newValue = int.tryParse(text);
      if (newValue != null) {
        if (newValue > 140 || newValue < 210) {
          authCubit.updateHeight(newValue);
        } else {
          _showSnackBar("الطول يجب ان يكون اكبر من او يساوي 160 cm");
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
    _heightController.removeListener(_handleheightChange);
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => 
      current is IncreamentCounter || current is DecreamentCounter ,
      builder: (context, state) {
        if (state is IncreamentCounter || state is DecreamentCounter) {
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
                onLongPressEnd: (_) => authCubit.stopTimerHeight(),
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
                child: TextFormField(
                  cursorColor: AppColors.mainColor,
                  controller: _heightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.cairo24Boldmaincolor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "برجاء ادخال الطول";
                    }
                    int? newValue = int.tryParse(value);
                    if (newValue == null || newValue < 140 || newValue > 210) {
                      return "الطول يجب ان يكون اكبر من او يساوي 140 cm";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (Form.of(context).validate()) {
                      _showSnackBar(
                          "الطول يجب ان يكون اكبر من او يساوي 140 cm");
                      _heightController.text =
                          authCubit.heightCounter.toString();
                    } else {
                      int newValue = int.parse(value);
                      authCubit.updateHeight(newValue);
                    }
                  },
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseHeight(),
                onLongPressEnd: (_) => authCubit.stopTimerHeight(),
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
