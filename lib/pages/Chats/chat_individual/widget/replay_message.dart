import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReplyMessage extends StatelessWidget {
  final MessageModel messageData;
  const ReplyMessage({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 300.sp, maxWidth: size - 45),
        child: Bubble(
          color: COLOR_WHITE,
          elevation: 1,
          nip: BubbleNip.leftTop,
          margin: BubbleEdges.symmetric(horizontal: 15.sp, vertical: 10.sp),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 5.sp, right: 60.sp, top: 5.sp, bottom: 50.sp),
                child: Text(
                  messageData.message,
                  style: TextStyle(fontSize: 32.sp, color: Colors.black),
                ),
              ),
              addHorizontalSpace(16.sp),
              Positioned(
                  bottom: 4.sp,
                  right: 15.sp,
                  child: Text(
                    DateFormat('hh:mm a').format(messageData.time),
                    style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
