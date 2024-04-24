import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/feature/auth/logic/cubit/auth_cubit.dart';

class HeightCounter extends StatefulWidget {
  const HeightCounter({super.key});

  @override
  State<HeightCounter> createState() => _HeightCounterState();
}

late AuthCubit authCubit;

class _HeightCounterState extends State<HeightCounter> {
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
              InkWell(
                onLongPress: () => authCubit.onLongPressedincreamnetHeight(),
                onTap: () => authCubit.onPreesedIncreamnetHeight(),
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
                '${authCubit.heightCounter}',
                style: AppTextStyles.cairo24Boldmaincolor,
              ),
              InkWell(
                onLongPress: () => authCubit.decrementHeight(),
                onTap: () => authCubit.decrementHeight(),
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
