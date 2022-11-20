import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class ReplyOfferMessage extends StatelessWidget {
  final MessageModel messageData;
  const ReplyOfferMessage({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150, maxWidth: size - 45),
        child: Bubble(
          color: COLOR_LIGHT_BLACK,
          elevation: 1,
          nip: BubbleNip.leftTop,
          margin: const BubbleEdges.symmetric(horizontal: 10, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 8)
                        .copyWith(right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "YOUR OFFER",
                      style: heading6.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    Text("₹ ${messageData.message}",
                        style: heading2InBold.copyWith(color: Colors.white)),
                  ],
                ),
              ),
              addHorizontalSpace(8),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Text(
                    DateFormat('hh:mm a').format(messageData.time),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
