import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nourish_me/core/helpers/cache_helper.dart';
import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/cubit/auth_cubit.dart';

class SocialIntegration extends StatelessWidget {
  final Function() integrateWithGoogle;
  const SocialIntegration({
    super.key,
    required this.integrateWithGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                'أو من خلال',
                style: AppTextStyles.cairo12SemiBoldBlack,
              ),
            ),
            const Expanded(
              child: Divider(
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Center(
          child: PlatformCard(
            integrateWith: integrateWithGoogle,
            platformIcon: Assets.iconsGoogle,
          ),
        ),
      ],
    );
  }
}

class PlatformCard extends StatelessWidget {
  const PlatformCard({
    super.key,
    required this.integrateWith,
    required this.platformIcon,
  });

  final Function() integrateWith;
  final String platformIcon;

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is GoogleLoginSuccess) {
          CacheHelper cacheHelper = CacheHelper();
          Navigator.pop(context);
          cacheHelper.saveData(key: 'googleRememberMe', value: 'yes');
          cacheHelper.saveData(
              key: 'email', value: state.loginModel!.data!['user']['email']);
          cacheHelper.saveData(
              key: 'name', value: state.loginModel!.data!['user']['name']);
          state.loginModel!.data!['user']['image'] == null
              ? cacheHelper.removeData(key: 'image')
              : cacheHelper.saveData(
                  key: 'image',
                  value: state.loginModel!.data!['user']['image']);
          cacheHelper.saveSecuredData(
              key: 'googleToken',
              value: state.loginModel!.data![AppConstants.token]);
          cacheHelper.saveData(
              key: 'isFirstQuestionsCompleteGoogle',
              value: state.loginModel!.data!['user']
                  [AppConstants.isFirstQuestionsComplete]);
          cacheHelper.saveData(
              key: 'isDataSaved',
              value: state.loginModel!.data!['user']
                  ['is_personal_data_answered']);
          cacheHelper.getData(key: 'isDataSaved') == 'yes'
              ? cacheHelper.getData(key: 'isFirstQuestionsCompleteGoogle') ==
                      'yes'
                  ? Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.bottomNavBar,
                      (route) => false,
                    )
                  : Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.questions,
                      arguments: 'googleLogin',
                      (route) => false,
                    )
              : Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.continueRegisterScreen,
                  arguments: 'googleLogin',
                  (route) => false,
                );
        }
        if (state is GoogleLoginFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          HelperMethods.showCustomSnackBarError(
            context,
            ErrorMessages.errorMessage(state.error!),
          );
          googleSignIn.signOut();
        }
        if (state is GoogleLoginLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      listenWhen: (previous, current) =>
          current is GoogleLoginFailure ||
          current is GoogleLoginSuccess ||
          current is GoogleLoginLoading,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () async {
          GoogleSignInAccount? googleSignInAccount =
              await googleSignIn.signIn().then(
            (value) async {
              GoogleSignInAuthentication googleSignInAuthentication =
                  await value!.authentication;
              String? accessToken = googleSignInAuthentication.accessToken;

              authCubit
                  .googleLogin('users/google/redirect', {'token': accessToken});
              return null;
            },
          ).catchError((e) async {
            await googleSignIn.signOut();
            log('error: ${e.toString()}');
            return null;
          });
          if (googleSignInAccount == null) {
            log('null : ${googleSignInAccount.toString()}');
            // await googleSignIn.signOut();
            return;
          }
        },
        child: SizedBox(
          height: 60.h,
          width: 60.h,
          child: Card(
            surfaceTintColor: Colors.white,
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            color: AppColors.white,
            child: Center(
              child: SvgPicture.asset(
                width: 30.w,
                height: 30.h,
                platformIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
