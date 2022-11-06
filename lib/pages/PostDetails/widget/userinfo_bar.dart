import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/text_style.dart';

class UserInfoBar extends StatelessWidget {
  final String url;
  final String userName;
  final VoidCallback onPress;
  const UserInfoBar(
      {super.key,
      required this.url,
      required this.userName,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20.sp),
        child: Row(
          children: [
            SizedBox(
                width: 150.sp,
                height: 150.sp,
                child: ShowUserPhoto(imageUrl: url)),
            Expanded(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName.toUpperCase(), style: heading5),
                    Text("Member since Aug 2022", style: cardSubTitle),
                    const SizedBox(height: 5)
                  ],
                ),
                subtitle: Text("See Profile",
                    style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 25.sp,
                        decoration: TextDecoration.underline)),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ));
  }
}
