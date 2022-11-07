import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/text_style.dart';

class HomeAccount extends StatefulWidget {
  const HomeAccount({super.key});

  @override
  State<HomeAccount> createState() => _HomeAccountState();
}

class _HomeAccountState extends State<HomeAccount> {
  var design = "";
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
                                color: Colors.black,
                                decoration: TextDecoration.underline))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(thickness: 2, color: Colors.black54),
            const SizedBox(height: 10),
            ListTile(
              leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("lib/assets/images/BiS.png")),
              title: Text("Help center and legal terms"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const Divider(thickness:2 ,height: 30),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Help center and legal terms"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const Divider(thickness:2 ,height: 30),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("Login or Register"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
