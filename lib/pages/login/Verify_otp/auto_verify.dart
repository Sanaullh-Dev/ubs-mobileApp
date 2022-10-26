import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ubs/pages/login/password/password_screen.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AutoVerify extends StatefulWidget {
  final String hashNo;
  final String userId;
  final String appSignature;
  const AutoVerify(
      {super.key,
      required this.hashNo,
      required this.userId,
      required this.appSignature});

  @override
  State<AutoVerify> createState() => _AutoVerifyState();
}

class _AutoVerifyState extends State<AutoVerify> with CodeAutoFill {
  Timer? countdownTimer;
  late Duration myDuration;
  var timeOut = 0;
  String? appSignature;
  String? otpCode;
  Rx<bool> resendOtp = false.obs;
  Rx<String> secondsStr = "".obs;
  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
    onLoad();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  onLoad() {
    listenForCode();
    myDuration = const Duration(minutes: 1);
    resendOtp.value = false;
    secondsStr.value = strDigits(myDuration.inSeconds);
    timeOut = myDuration.inSeconds.toInt();
    startTimer();
  }

  @override
  void codeUpdated() async{
      otpCode = code!;
      print(otpCode);
      if (otpCode != null || otpCode != "") {
        var res = await RemoteServices.verifyOTP(widget.hashNo, int.parse(otpCode!),widget.userId);
        if (res != null) {
          Get.to(PasswordScreen(userId: widget.userId, newUser: true, loginType: "phone",));
        }
      }
    
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final seconds = myDuration.inSeconds - 1;
    if (seconds < 0) {
      resendOtp.value = true;
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    secondsStr.value = strDigits(myDuration.inSeconds);
  }

  @override
  void dispose() {
    cancel();
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification", style: appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Obx(() {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(50.h),
                  Text("Welcome Back",
                      style: heading1InBold, textAlign: TextAlign.left),
                  addVerticalSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("We sent a 4-digit code to ${widget.userId}",
                          style: messageLabel),
                      IconButton(
                          padding: EdgeInsets.all(5.sp),
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            FontAwesomeIcons.penToSquare,
                            size: 50.sp,
                          ))
                    ],
                  ),
                  addVerticalSpace(80.h),
                  Image.asset("lib/assets/images/find.png",
                      height: 300.sp, width: 300.sp),
                  addVerticalSpace(50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.sp),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.cyan[100],
                      valueColor: const AlwaysStoppedAnimation(Colors.cyan),
                      value:
                          1 * (timeOut - int.parse(secondsStr.value)) / timeOut,
                      minHeight: 60.sp,
                    ),
                  ),
                  addVerticalSpace(50.h),
                  resendOtp.value == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("lib/assets/images/stopwatch.png",
                                height: 40.sp, width: 40.sp),
                            addHorizontalSpace(15.sp),
                            Text(
                              "${secondsStr.value} S",
                              style: heading5,
                            )
                          ],
                        )
                      : GestureDetector(
                          onTap: () async {
                            countdownTimer!.cancel();
                            onLoad();
                            // var res = await RemoteServices.getOTP(
                            //     widget.userId, widget.appSignature);
                            // if (res != null) {
                            //   onLoad();
                            // }
                          },
                          child: Text("Resend OTP",
                              style: GoogleFonts.poppins(
                                  color: COLOR_BLACK,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 34.sp,
                                  decoration: TextDecoration.underline)),
                        ),
                  addVerticalSpace(70.h),
                  Text("We are trying to detect code", style: heading2InBold),
                ],
              );
            })),
      ),
    ));
  }
}



// import 'dart:async';
// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ubs/pages/login/password/password_screen.dart';
// import 'package:ubs/services/remote_services.dart';
// import 'package:ubs/sharing_widget/widget_fun.dart';
// import 'package:ubs/utils/constants.dart';
// import 'package:ubs/utils/text_style.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class AutoVerify extends StatefulWidget {
//   final String hashNo;
//   final String userId;
//   final String appSignature;
//   const AutoVerify(
//       {super.key,
//       required this.hashNo,
//       required this.userId,
//       required this.appSignature});

//   @override
//   State<AutoVerify> createState() => _AutoVerifyState();
// }

// // Dear Customer, Use code 4760 to login to your BIS account. Never share your OTP with anyone. RT2U4YIusEg
// class _AutoVerifyState extends State<AutoVerify> {
//   Timer? countdownTimer;
//   late Duration myDuration;
//   var timeOut = 0;
//   String? appSignature;
//   String? otpCode;
//   Rx<bool> resendOtp = false.obs;
//   Rx<String> secondsStr = "".obs;
//   String strDigits(int n) => n.toString().padLeft(2, '0');

//   Future<void> initSmsListener() async {
//     String? commingSms;
//     try {
//       commingSms = await AltSmsAutofill().listenForSms;
//     } on PlatformException {
//       commingSms = 'Failed to get Sms.';
//     }
//     if (!mounted) return;
//     setState(() async {
//       print(commingSms!);
//       int le = commingSms.length;
//       // print(commingSms.substring(le-12 , le));
//       String appsing = commingSms.substring(le - 12, le);
//       // print(commingSms.substring(23,28));
//       otpCode = commingSms.substring(23, 28);
//       if (appsing == appsing) {
//         var res =
//             await RemoteServices.verifyOTP(widget.hashNo, int.parse(otpCode!));
//         if (res != null) {
//           Get.to(PasswordScreen(userId: widget.userId, newUser: true));
//         }
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     initSmsListener();
//     onLoad();
//   }

//   onLoad() {
//     myDuration = const Duration(minutes: 1);
//     resendOtp.value = false;
//     secondsStr.value = strDigits(myDuration.inSeconds);
//     timeOut = myDuration.inSeconds.toInt();
//     startTimer();
//   }

//   void startTimer() {
//     countdownTimer =
//         Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//   }

//   void setCountDown() {
//     final seconds = myDuration.inSeconds - 1;
//     if (seconds < 0) {
//       resendOtp.value = true;
//       countdownTimer!.cancel();
//     } else {
//       myDuration = Duration(seconds: seconds);
//     }
//     secondsStr.value = strDigits(myDuration.inSeconds);
//   }

//   @override
//   void dispose() {
//     // cancel();
//     AltSmsAutofill().unregisterListener();
//     countdownTimer!.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         title: Text("OTP Verification", style: appBarTitle),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 40.sp),
//             child: Obx(() {
//               return Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   addVerticalSpace(50.h),
//                   Text("Welcome Back",
//                       style: heading1InBold, textAlign: TextAlign.left),
//                   addVerticalSpace(10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("We sent a 4-digit code to ${widget.userId}",
//                           style: messageLabel),
//                       IconButton(
//                           padding: EdgeInsets.all(5.sp),
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: Icon(
//                             FontAwesomeIcons.penToSquare,
//                             size: 50.sp,
//                           ))
//                     ],
//                   ),
//                   addVerticalSpace(80.h),
//                   Image.asset("lib/assets/images/find.png",
//                       height: 300.sp, width: 300.sp),
//                   addVerticalSpace(50.h),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 80.sp),
//                     child: LinearProgressIndicator(
//                       backgroundColor: Colors.cyan[100],
//                       valueColor: const AlwaysStoppedAnimation(Colors.cyan),
//                       value:
//                           1 * (timeOut - int.parse(secondsStr.value)) / timeOut,
//                       minHeight: 60.sp,
//                     ),
//                   ),
//                   addVerticalSpace(50.h),
//                   resendOtp.value == false
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("lib/assets/images/stopwatch.png",
//                                 height: 40.sp, width: 40.sp),
//                             addHorizontalSpace(15.sp),
//                             Text(
//                               "${secondsStr.value} S",
//                               style: heading5,
//                             )
//                           ],
//                         )
//                       : GestureDetector(
//                           onTap: () async {
//                             countdownTimer!.cancel();
//                             onLoad();
//                             initSmsListener();
//                             var res = await RemoteServices.getOTP(
//                                 widget.userId, widget.appSignature);
//                             if (res != null) {
//                               onLoad();
//                             }
//                           },
//                           child: Text("Resend OTP",
//                               style: GoogleFonts.poppins(
//                                   color: COLOR_BLACK,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 34.sp,
//                                   decoration: TextDecoration.underline)),
//                         ),
//                   addVerticalSpace(70.h),
//                   Text("We are trying to detect code", style: heading2InBold),
//                 ],
//               );
//             })),
//       ),
//     ));
//   }
// }
