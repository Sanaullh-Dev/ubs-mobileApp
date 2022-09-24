import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

class PhotoTile extends StatefulWidget {
  final String imgPath;
  final VoidCallback onPress;
  final Size size;
  final int selectIndex;
  const PhotoTile(
      {super.key,
      required this.imgPath,
      required this.onPress,
      required this.size,
      required this.selectIndex});

  @override
  State<PhotoTile> createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        height: widget.size.width / 3,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: COLOR_GREY.withAlpha(150), width: 1)),
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.file(File(widget.imgPath), fit: BoxFit.cover)),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 25,
                width: 25,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: widget.selectIndex >= 0
                      ? Colors.black
                      : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Center(
                  child: Text(
                    widget.selectIndex >= 0
                        ? (widget.selectIndex + 1).toString()
                        : "",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 30,
              child: widget.selectIndex == 0
                  ? Container(
                      color: COLOR_PRIMARY,
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: const Text(
                        "MAIN PHOTO",
                        style: TextStyle(
                            color: COLOR_BLACK,
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
