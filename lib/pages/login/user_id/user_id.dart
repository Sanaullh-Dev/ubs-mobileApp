import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/text_style.dart';

class UserId extends StatefulWidget {
  final String idType;
  final bool isError;
  const UserId({super.key, required this.idType, required this.isError});

  @override
  State<UserId> createState() => _UserIdState();
}

class _UserIdState extends State<UserId> {
  TextEditingController countryCode = TextEditingController(text: "+91");
  final LoginController loginControl = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    // TextEditingController loginUname = new TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.h),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(50.h),
          SizedBox(
            width: 180.w,
            height: 180.w,
            child: Image.asset("lib/assets/images/user.png"),
          ),
          addVerticalSpace(40.h),
          Text(
              widget.idType == "phone"
                  ? "Enter your Phone Number"
                  : "Enter your Register Email-Id",
              style: heading1),
          addVerticalSpace(40.h),
          widget.idType == "phone" ? numberTextfield() : emailTextfield(),
          widget.isError
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.sp),
                  child: Text(
                    widget.idType == "phone"
                        ? "Enter valid phone no"
                        : "Enter valid Email-Id",
                    style: heading6.copyWith(color: Colors.red),
                  ),
                )
              : addVerticalSpace(40.h),
          Text(
              widget.idType == "phone"
                  ? "We'll send you a verification code on the same number."
                  : "If you are a new user than please choose any other login option from previous screen",
              style: heading5),
          addVerticalSpace(20.h),
        ],
      ),
    );
  }

  Widget numberTextfield() {
    return Row(
      children: [
        SizedBox(
          width: 160.sp,
          child: TextField(
            controller: countryCode,
            enabled: false,
            style: textfield,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
              hintText: "+ 91 ",
              hintStyle: textfield,
              label: Text("Country", style: labelText),
            ),
          ),
        ),
        addHorizontalSpace(30.w),
        Expanded(
          flex: 4,
          child: TextField(
            style: textfield,
            keyboardType: TextInputType.number,
            maxLength: 10,
            autofocus: true,
            onChanged: (val) {
              loginControl.loginId.value = val;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
              counterText: "",
              label: Text("Phone No", style: labelText),
              hintText: "Ex. 9788878444",
              hintStyle: textfield,
            ),
          ),
        )
      ],
    );
  }

  Widget emailTextfield() {
    return TextField(
      style: textfield,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      onChanged: (val) {
        loginControl.loginId.value = val;
      },
      decoration: InputDecoration(
        counterText: "",
        label: Text("Email", style: labelText),
        hintText: "Ex. xyz@gmail.com",
        hintStyle: textfield,
      ),
    );
  }
}
