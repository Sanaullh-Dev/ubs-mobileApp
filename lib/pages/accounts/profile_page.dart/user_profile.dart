import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 50.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  SizedBox(
                      width: 180.sp,
                      height: 180.sp,
                      child: Image.asset("lib/assets/images/user.png")),
                  Expanded(
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text("5", style: heading2InBold),
                                  Text("Following", style: heading6)
                                ],
                              ),
                              const VerticalDivider(
                                  color: COLOR_BLACK, thickness: 1, width: 20),
                              Column(
                                children: [
                                  Text("15", style: heading2InBold),
                                  Text("Followers", style: heading6)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Follow")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("User Name", style: heading5),
            const SizedBox(height: 5),
            Text("Member since from Oct 2022", style: heading6),
            const Divider(thickness: 3, color: Colors.black38, height: 60),
            Text("Published ads", style: sectionTitle),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 25),
                    height: 150,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10)),
                            child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                    "lib/assets/images/add/iphone8.jpg",
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Text("₹ 22,000", style: heading4),
                                const SizedBox(height: 5),
                                Text("Title of ads", style: titleLabel),
                                const Spacer(),
                                Row(
                                  children: const [
                                    Icon(Icons.location_on, size: 25),
                                    SizedBox(width: 5),
                                    Text("Location Name"),
                                    Spacer(),
                                    Text("Today"),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
