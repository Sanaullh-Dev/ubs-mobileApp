import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class OwnMessage extends StatelessWidget {
  const OwnMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 160,
          maxWidth: size - 45),
        child: Bubble(
          color: COLOR_PRIMARY,
          padding: BubbleEdges.all(0),
          margin: BubbleEdges.symmetric(horizontal: 10, vertical: 5),
          nip: BubbleNip.rightTop,
          elevation: 2,
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 10, right: 30, top: 5, bottom: 20),
                child: Text(
                  // "Hi I am sanaulla shaikh. I am from MH WW solapur. And I am looking for new mobile phone",
                  "H",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      
                      Text("04:30 am", style: TextStyle(fontSize: 12, color: Colors.black),),
                      addHorizontalSpace(8),
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: Colors.blue,
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
