import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/utils/text_style.dart';

class HomeAccount extends StatelessWidget {
  final UserLogin userLogin;
  const HomeAccount({super.key ,  required this.userLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  SizedBox(
                      width: 180.sp,
                      height: 180.sp,
                      child: Image.asset("lib/assets/images/user.png")),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Welcome To BIS", style: heading2InBold),
                        Text("Login in to your account >",
                            style: heading5.copyWith(
                              fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decoration: TextDecoration.underline))
                      ],
                    ),
                  )
                ],
              ),
            ),
            // const Divider(thickness: 1, color: Colors.black54),
            const SizedBox(height: 10),
            ListTile(
              leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "lib/assets/images/bis_icon.png",
                    color: Colors.blueGrey,
                    colorBlendMode: BlendMode.color,
                  )),
              title: Text("Help & Support", style: titleLabel.copyWith(color: Colors.black)),
              subtitle: Text("Help center and legal terms", style: titleLabel),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(thickness: 2, height: 30),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.earthAsia,
                size: 65.sp,
                color: Colors.blueGrey,
              ),
              title: Text("Select Language", style: titleLabel.copyWith(color: Colors.black)),
              subtitle: Text("English", style: subtitleLabel),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(thickness: 2, height: 30),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("Login or Register" , style: buttonTextStyle.copyWith(color: Colors.black)),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
