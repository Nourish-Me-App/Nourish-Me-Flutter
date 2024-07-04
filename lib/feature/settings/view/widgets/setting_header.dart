import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/cubit/settings_cubit.dart';
import 'choose_image_source_dialog.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var settingCubit = BlocProvider.of<SettingsCubit>(context);
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
        if (state is UpdateProfileFailed) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error));
        }
        if (state is UpdateProfileSuccess) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم رفع الصورة الشخصية بنجاح');
          CacheHelper().saveData(
              key: 'image', value: state.updateProfileModel.data!.image);
        }
      },
      listenWhen: (context, state) =>
          state is UpdateProfileFailed ||
          state is UpdateProfileLoading ||
          state is UpdateProfileSuccess,
      buildWhen: (context, state) => state is UpdateProfileSuccess,
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              height: 120.h,
              width: 85.w,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChooseImageSourceDialog(
                      cameraPick: () async {
                        XFile? pickedImage =
                            await settingCubit.cameraPick().then((value) {
                          Navigator.pop(context);
                          return value;
                        });
                        pickedImage != null
                            ? settingCubit.updateProfile(
                                AppConstants.updateProfile,
                                {
                                  'image': await MultipartFile.fromFile(
                                    pickedImage.path,
                                    filename: pickedImage.path.split('/').last,
                                  ),
                                },
                              )
                            : null;
                      },
                      galleryPick: () async {
                        XFile? pickedImage =
                            await settingCubit.galleryPick().then((value) {
                          Navigator.pop(context);
                          return value;
                        });
                        pickedImage != null
                            ? settingCubit.updateProfile(
                                AppConstants.updateProfile,
                                {
                                  'image': await MultipartFile.fromFile(
                                    pickedImage.path,
                                    filename: pickedImage.path.split('/').last,
                                  ),
                                },
                              )
                            : null;
                      },
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    CacheHelper().getData(key: 'image') == null
                        ? CircleAvatar(
                            backgroundColor: AppColors.dietContainerColor,
                            radius: 70.r,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: AppColors.mainColor,
                                size: 40.r,
                              ),
                            ),
                          )
                        : Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  CacheHelper().getData(key: 'image'),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                    Positioned(
                      top: CacheHelper().getData(key: 'image') == null
                          ? 80.h
                          : 83.h,
                      left: CacheHelper().getData(key: 'image') == null
                          ? 50.w
                          : 55.w,
                      child: CircleAvatar(
                        backgroundColor: AppColors.mainColor,
                        radius: CacheHelper().getData(key: 'image') == null
                            ? 17.r
                            : 15.r,
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 15.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CacheHelper().getData(key: 'name'),
                    style: AppTextStyles.cairo18BoldBlack,
                  ),
                  Text(
                    softWrap: true,
                    CacheHelper().getData(key: 'email'),
                    style: AppTextStyles.cairo16SemiBoldBlack.copyWith(
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
