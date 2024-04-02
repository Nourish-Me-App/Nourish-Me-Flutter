// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'otp.dart';

// class OtpRow extends StatefulWidget {
//   const OtpRow({super.key});

//   @override
//   State<OtpRow> createState() => _OtpRowState();
// }

// class _OtpRowState extends State<OtpRow> {
//     TextEditingController otpControllerone = TextEditingController();

//   TextEditingController otpControllertwo = TextEditingController();

//   TextEditingController otpControllerthree = TextEditingController();

//   TextEditingController otpControllerfour = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300.w,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Otp(
//             context: context,
//             otpController: otpControllerone,
//           ),
//           SizedBox(width: 16.w),
//           Otp(
//             context: context,
//             otpController: otpControllertwo,
//           ),
//           SizedBox(width: 16.w),
//           Otp(
//             context: context,
//             otpController: otpControllerthree,
//           ),
//           SizedBox(width: 16.w),
//           Otp(
//             context: context,
//             otpController: otpControllerfour,
//           ),
//         ],
//       ),
//     );
//   }
// }
