import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/imports/app_routes_imports.dart';

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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 342.w,
            height: 80.h,
            child: Card(
              color: AppColors.workOutCardbackGroundColor,
              elevation: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.h, bottom: 7.w, top: 7.w),
                    child: ClipRect(
                      child: Container(
                          width: 66.w,
                          height: 66.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.fill,
                            ),
                          )),
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
                    icon: Image.asset(Assets.imagesArrowRight),
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
