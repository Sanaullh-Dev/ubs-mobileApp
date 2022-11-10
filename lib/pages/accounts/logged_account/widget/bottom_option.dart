import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubs/pages/accounts/controller/account_controller.dart';
import 'package:ubs/utils/text_style.dart';

Future bottomOption(BuildContext context, AccountController accCont) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            children: [
              listTile(
                  Icons.camera_alt_outlined,
                  "Take a picture",
                  () => accCont
                      .imagePickFromGallery("camera")
                      .then((value) => Navigator.pop(context))),
              listTile(
                  Icons.photo_outlined,
                  "Select from Gallery",
                  () => accCont
                      .imagePickFromGallery("gallery")
                      .then((value) => Navigator.pop(context))),
              listTile(FontAwesomeIcons.trashCan, "Remove picture",
                  () => {accCont.removerImage(), Navigator.pop(context)}),
            ],
          ),
        );
      });
}

Widget listTile(IconData icon, String labelName, VoidCallback onPress) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
    onTap: onPress,
    leading: Icon(icon, size: 50.sp, color: Colors.black),
    title: Text(labelName, style: heading6),
  );
}