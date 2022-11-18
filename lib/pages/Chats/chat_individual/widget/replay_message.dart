import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class ReplyMessage extends StatelessWidget {
  final MessageModel messageData;
  const ReplyMessage({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150, maxWidth: size - 45),
        child: Bubble(
          color: COLOR_WHITE,
          elevation: 1,
          nip: BubbleNip.leftTop,
          margin: const BubbleEdges.symmetric(horizontal: 10, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, top: 5, bottom: 30),
                child: Text(
                  messageData.message,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
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
