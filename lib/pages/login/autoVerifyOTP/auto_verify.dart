import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoVerify extends StatefulWidget {
  const AutoVerify({super.key});

  @override
  State<AutoVerify> createState() => _AutoVerifyState();
}

class _AutoVerifyState extends State<AutoVerify> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);
  var timeOut = 0;
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countdownTimer!.cancel();
  }

  void setCountDown() {
    setState(() {
      final seconds = myDuration.inSeconds - 1;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeOut = myDuration.inSeconds.toInt();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds);
    final ss = myDuration.inSeconds.toInt();
    print(ss);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification", style: appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.sp),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(50.h),
              Text("Welcome Back",
                  style: heading1InBold, textAlign: TextAlign.left),
              addVerticalSpace(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("We sent a 4-digit code to +91 7499604663",
                      style: messageLabel),
                  IconButton(
                      padding: EdgeInsets.all(5.sp),
                      onPressed: () {},
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
                  value: 1 * (timeOut - int.parse(seconds)) / timeOut,
                  minHeight: 60.sp,
                ),
              ),
              addVerticalSpace(50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/assets/images/stopwatch.png",
                      height: 40.sp, width: 40.sp),
                  addHorizontalSpace(15.sp),
                  Text(
                    "$seconds S",
                    style: heading5,
                  )
                ],
              ),
              addVerticalSpace(70.h),
              Text("We are trying to detect code", style: heading2InBold)
            ],
          ),
        ),
      ),
    ));
  }
}
