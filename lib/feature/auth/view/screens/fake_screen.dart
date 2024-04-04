import '../../../../core/imports/login_imports.dart';
import '../../../../core/theme/app_colors.dart';

class FakeScreen extends StatelessWidget {
  const FakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              onPressed: () {
                CacheHelper().removeData(key: AppConstants.token);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.signUpScreen,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Hello User',
          style: AppTextStyles.cairo32BoldOtpFontColor.copyWith(
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}
