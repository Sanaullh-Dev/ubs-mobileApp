import 'package:flutter/material.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController countryCode = new TextEditingController();
    TextEditingController loginUname = new TextEditingController();
    countryCode.text = "+ 91";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
          title: Text(
            "Login",
            style: heading1,
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 150.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(50.h),
                  SizedBox(
                    width: 200.w,
                    height: 200.w,
                    child: Image.asset("lib/assets/images/user.png"),
                  ),
                  addVerticalSpace(20.h),
                  Text("Enter your Phone Number", style: heading1),
                  addVerticalSpace(10.h),
                  Text("We'll send you a verification code on the same number.",
                      style: heading4),
                  addVerticalSpace(20.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: TextField(
                          controller: countryCode,
                          enabled: false,
                          style: textfield,
                          decoration: InputDecoration(
                              hintText: "+ 91 ",
                              hintStyle: heading5,
                              label: Text("Country", style: heading6)),
                        ),
                      ),
                      addHorizontalSpace(50.w),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          style: textfield,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            label: Text("Phone No", style: heading6),
                            hintText: "Ex. 9788878444",
                            hintStyle: heading5,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
