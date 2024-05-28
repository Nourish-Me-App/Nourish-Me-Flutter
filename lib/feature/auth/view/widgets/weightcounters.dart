import 'package:nourish_me/core/imports/app_routes_imports.dart';

import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class WeightCounter extends StatefulWidget {
  const WeightCounter({super.key});

  @override
  State<WeightCounter> createState() => _WeightCounterState();
}

late AuthCubit authCubit;

class _WeightCounterState extends State<WeightCounter> {
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
                onLongPressStart: (_) {
                  authCubit.startTimerIncreaseWeight();
                },
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () {
                  authCubit.onpreesedincreamnetWeight();
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
                '${authCubit.weightCounter}',
                style: AppTextStyles.cairo24Boldmaincolor,
              ),
              GestureDetector(
                onLongPressStart: (_) => authCubit.startTimerDecreaseWeight(),
                onLongPressEnd: (_) => authCubit.stopTimer(),
                onTap: () => authCubit.decrementWeight(),
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
