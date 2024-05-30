import 'package:flutter_svg/svg.dart';
import 'package:nourish_me/core/helpers/app_images.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/imports/login_imports.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(Assets.noInternetConnection),
                    SizedBox(height: 10.h),
                    Text('لا يوجد اتصال بالإنترنت',
                        style: AppTextStyles.cairo12BoldMainColor.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                    Text('اتصل بالإنترنت ثم أعد المحاولة مرة اخري ',
                        style: AppTextStyles.cairo12BoldMainColor.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              );
  }
}