import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubs/utils/constants.dart';

class demoWidget extends StatefulWidget {
  const demoWidget({Key? key}) : super(key: key);

  @override
  State<demoWidget> createState() => _demoWidgetState();
}

class _demoWidgetState extends State<demoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          onChanged: (st) {
            print(st);
          },
          onSubmitted: (g) {
            print(g);
          },
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          minLines: 1,
          style: const TextStyle(
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            hintText: "Type a message",
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                FontAwesomeIcons.paperclip,
                color: COLOR_INDICATOR,
                size: 25,
              ),
            ),
            suffixIcon: Icon(FontAwesomeIcons.microphone),
            hintStyle: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
