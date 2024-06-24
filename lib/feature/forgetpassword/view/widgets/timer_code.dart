import 'dart:async';
import 'dart:developer';

import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/auth_requests.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/imports/signup_screen_imports.dart';
import '../../data/models/forget_password_model.dart';
import '../../logic/forget_password_cubit.dart';

class TimerCode extends StatefulWidget {
  const TimerCode({
    super.key,
  });

  @override
  State<TimerCode> createState() => _TimerCodeState();
}

late ForgetPasswordCubit forgetPasswordCubit;

class _TimerCodeState extends State<TimerCode> {
  @override
  void initState() {
    forgetPasswordCubit = context.read<ForgetPasswordCubit>();
    super.initState();
  }

  int resendTime = 120;
  bool codeSent = false;
  ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

  resendCode()async {
    sendCodeTimer();
    AuthRequests.forgetPassword(
      forgetPasswordCubit: forgetPasswordCubit,
      forgetPasswordModel: forgetPasswordModel,
      email:(await CacheHelper().getData(key: 'email'))!,
    );
    log('resend code');
  }

  sendCodeTimer() {
    setState(() {
      codeSent = true;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime--;
        if (resendTime == 0) {
          timer.cancel();
          resendTime = 120;
        }
      });
    });
    Timer(const Duration(seconds: 120), () {
      setState(() {
        codeSent = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error!));
        }
        if (state is ForgetPasswordLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
        if (state is ForgetPasswordSuccess) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarSuccess(
              context, 'تم ارسال رمز التحقق بنجاح');
        }
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: codeSent ? null : resendCode,
              child: Text('أعد إرسال الرمز',
                  style: AppTextStyles.cairo18BoldBlack),
            ),
            codeSent
                ? Text(
                    '($resendTime)',
                    style: AppTextStyles.cairo12BoldMainColor,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
