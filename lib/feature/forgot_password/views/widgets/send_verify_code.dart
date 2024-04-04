import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/imports/signup_screen_imports.dart';

class SendCode extends StatefulWidget {
  const SendCode({
    super.key,
  });

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  int resendTime = 60;
  bool enableResend = false;
  late Timer countdownTimer;
  bool isButton = true;
  @override
  initState() {
    super.initState();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (resendTime != 0) {
        setState(() {
          resendTime--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void resendCode() {
    setState(() {
      resendTime = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 110.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => enableResend ? resendCode() : null,
              child: Text(
                'أعد إرسال الرمز',
                style: enableResend
                    ? AppTextStyles.cairo12RegularBlack
                    : AppTextStyles.cairo12RegularGrey,
              ),
            ),
            const Spacer(),
            Text(
              '($resendTime)',
              style: AppTextStyles.cairo12BoldMainColor,
            ),
          ],
        ),
      ),
    );
  }
}
