import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class OwnOfferMessage extends StatelessWidget {
  final MessageModel messageData;
  const OwnOfferMessage({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 160, maxWidth: size - 45),
        child: Bubble(
          color: COLOR_PRIMARY,
          padding: const BubbleEdges.all(0),
          margin: const BubbleEdges.symmetric(horizontal: 10, vertical: 5),
          nip: BubbleNip.rightTop,
          elevation: 2,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15)
                        .copyWith(right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("YOUR OFFER",
                        style: heading6.copyWith(
                            fontWeight: FontWeight.w700,
                            color: COLOR_WHITE)),
                    Text("₹ ${messageData.message}",
                        style:
                            heading2InBold.copyWith(color: COLOR_WHITE)),
                  ],
                ),
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(messageData.time),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      addHorizontalSpace(8),
                      Icon(
                        Icons.done_all,
                        size: 20,
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
