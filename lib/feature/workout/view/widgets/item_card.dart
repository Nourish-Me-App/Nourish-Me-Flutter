import 'package:nourish_me/core/imports/app_routes_imports.dart';
import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.title,
      required this.time,
      required this.image,
      this.onTap});

  final String title;
  final String time;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 80.h,
        child: Card(
          color: AppColors.workOutCardbackGroundColor,
          elevation: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.h, bottom: 7.w, top: 7.w),
                child: Image.asset(
                  image,
                  width: 66.w,
                  height: 66.h,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.cairo16BoldBlack),
                  Text(
                    time,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Image.asset('assets/images/ep_arrow-up-bold.png'),
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
