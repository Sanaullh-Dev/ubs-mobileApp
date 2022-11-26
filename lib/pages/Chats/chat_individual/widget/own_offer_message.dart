import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnOfferMessage extends StatelessWidget {
  final MessageModel messageData;
  const OwnOfferMessage({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 160.sp, maxWidth: size - 45),
        child: Bubble(
          color: primaryColor,
          padding: const BubbleEdges.all(0),
          margin: BubbleEdges.symmetric(horizontal: 25.sp, vertical: 20.sp),
          nip: BubbleNip.rightTop,
          elevation: 2,
          child: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 40.sp, horizontal: 30.sp)
                        .copyWith(right: 100.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("YOUR OFFER",
                        style: heading6.copyWith(
                            fontWeight: FontWeight.w700, color: whiteColor)),
                    Text("₹ ${messageData.message}",
                        style: heading2InBold.copyWith(color: whiteColor)),
                  ],
                ),
              ),
              Positioned(
                  bottom: 4.sp,
                  right: 15.sp,
                  child: Row(
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(messageData.time),
                        style:TextStyle(fontSize: 26.sp, color: Colors.black),
                      ),
                      addHorizontalSpace(12.sp),
                      Icon(
                        Icons.done_all,
                        size: 40.sp,
                        color: messageData.status == "read"
                            ? Colors.blue
                            : Colors.grey,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
