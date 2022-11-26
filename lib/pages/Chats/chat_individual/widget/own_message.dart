import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnMessage extends StatelessWidget {
  final MessageModel messageData;
  const OwnMessage({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 310.sp, maxWidth: size - 80),
        child: Bubble(
          color: secondaryColor,
          padding: const BubbleEdges.all(0),
          margin: BubbleEdges.symmetric(horizontal: 25.sp, vertical: 20.sp),
          nip: BubbleNip.rightTop,
          elevation: 2,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.sp, right: 60.sp, top: 10.sp, bottom: 60.sp),
                child: Text(
                  messageData.message,
                  style: TextStyle(fontSize: 32.sp, color: Colors.black),
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
                      addHorizontalSpace(15.sp),
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
