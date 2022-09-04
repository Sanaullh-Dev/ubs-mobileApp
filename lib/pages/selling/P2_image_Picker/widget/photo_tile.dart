import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:ubs/utils/constants.dart';

class PhotoTile extends StatefulWidget {
  final Medium mediaImg;
  final VoidCallback onpress;
  final Size size;
  final int selectIndex;
  const PhotoTile(
      {super.key,
      required this.mediaImg,
      required this.onpress,
      required this.size,
      required this.selectIndex});

  @override
  State<PhotoTile> createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  String _path = "";

  @override
  void initState() {
    super.initState();
    getPath();
  }

  getPath() async {
    File list = await PhotoGallery.getFile(mediumId: widget.mediaImg.id);
    if (list != null) {
      _path = list.path.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        height: widget.size.width / 3,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: COLOR_GREY.withAlpha(150), width: 1)),
        child: Stack(
          children: [
            Center(
              child:
                  //  _path == ""
                  //     ? const SizedBox()
                  //     : Image.file(File(_path), fit: BoxFit.cover)
                  FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: PhotoProvider(
                  mediumId: widget.mediaImg.id,
                ),
              ),
            ),
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
              left: 0,
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
                            fontSize: 10,
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
