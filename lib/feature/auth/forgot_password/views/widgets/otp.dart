// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_text_styles.dart';

// class Otp extends StatefulWidget {
//   Otp({super.key, required this.otpController, required this.context});
//   TextEditingController otpController = TextEditingController();
//   BuildContext context;

//   @override
//   State<Otp> createState() => _OtpState();
// }

// class _OtpState extends State<Otp> {
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: SizedBox(
//         height: 58.h,
//         width: 58.w,
//         child: TextFormField(
//           controller: widget.otpController,
//           cursorColor: const Color(0xff747474),
//           style: AppTextStyles.cairo32BoldOtpFontColor,
//           keyboardType: TextInputType.number,
//           textAlign: TextAlign.center,
//           inputFormatters: [
//             LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           onChanged: (value) {
//             if (value.length == 1) {
//               FocusScope.of(context).nextFocus();
//             }
//           },
//           decoration: InputDecoration(
//             fillColor: AppColors.otpBackGround,
//             filled: true,
//             contentPadding: EdgeInsets.symmetric(vertical: 58.h),
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(7.r)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
